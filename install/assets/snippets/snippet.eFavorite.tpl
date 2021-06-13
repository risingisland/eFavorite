//<?php
/**
 * eFavorite
 * 
 * Favorites
 *
 * @author      webber (web-ber12@yandex.ru)
 * @category    snippet
 * @version     0.2
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @modx_category Content
 * @internal    @installset base, sample
*/
 
/*
Parameters:
&className - The name of the handler class. Default value: eFavorite.
&lifetime - The lifetime of the cookie. Default value: 2592000 = 30 days
&elementTotalId - The ID of the element that displays the total number of favorites. Default value: favorits_cnt
&elementClass - The class of the button element for Adding/Removing from favorites. This element must have the data-id="[+id+]" or data-id="[*id*]" attribute, to add a document. Default value: favorite. 
&elementActiveClass - The class of the active button element to Add/Remove from favorites. Default value: active
&addText - Tooltip when hovering over an inactive element. Default value: Add to wishlist
&removeText - Tooltip when hovering over the active element. Default value: Remove from wishlist

Integration with eFilter:
&setDocsForeFilterOnPage - если избранные элементы будут фильтроваться с помощью eFilter, то задать id нужной страницы тут.
&eFilterCallback=`1` - если eFilter вызывается в режиме ajax, не забудьте указать данный параметр

Call:
[!eFavorite!] - Include in header of the templates you wish to use. This sets the cookie to remember the selection.
the snippet will install the [+ eFavoriteDocs +] placeholder, which can be used later in the output [!DocLister? &documents=`[+eFavoriteDocs+]`!]
[!eFavorite? &setDocsForeFilterOnPage=`5`!]
will install an additional placeholder [+eFilter_search_ids+]on the page with id=5, which will be used when generating the output [!eFilter!]

if it is necessary to display the list, call it AGAINST in the right place with the usual DocLister parameters:
[!eFavorite? &tpl=`@CODE:[+pagetitle+]<hr>`!]

To organize several lists - favorites, wishlist, comparison - you can call several snippets with different id and different parameters
in header:
[!eFavorite!] //- for organizing favorites
[!eFavorite? &id=`wishlist` &elementTotalId=`total` &elementClass=`wishlist` &addText=`Add to wishlist` &removeText=`Remove from wishlist` &lifetime=`2592002`!] //- for wishlist

on the page showing favorites additional call:
[!eFavorite!]

On the show wishlist page an additional call:
[!eFavorite? &id=`wishlist`!]

*/


$out = '';
$id = isset($id) ? $id :  'favorite';

//повторный вызов - выводим список
$eFavoriteDocs = $modx->getPlaceholder('eFavoriteDocs_' . $id);
if ($eFavoriteDocs && !empty($eFavoriteDocs)) {
    if (isset($params['parents'])) {
        //задан parents - передаем список id как доп.условие - для показа "избранного из категории"
        $params['addWhereList'] = isset($params['addWhereList']) ? $params['addWhereList'] . ' AND c.id IN(' . $eFavoriteDocs . ')' : ' c.id IN(' . $eFavoriteDocs . ') ';
    } else {
        //иначе передаем в documents - для вывода полного списка избранного
        $params['documents'] = $eFavoriteDocs;
    }
    $out .= $modx->runSnippet("DocLister", $params);
    return $out;
}

//иначе - первичный вызов, инициализируем скрипты и плейсхолдеры
$className = isset($params['className']) ? $params['className'] : 'eFavorite';
require_once MODX_BASE_PATH . "assets/snippets/eFavorite/" . $className . ".class.php";
$class = "eFavorite\\" . $className;
$eFavorite = new $class($modx, $params);
$eFavorite->init($id);
$eFavorite->initJS();
$docs = $eFavorite->getDocList();
$modx->setPlaceholder('eFavoriteDocs_' . $id, $docs);
if (isset($params['setDocsForeFilterOnPage']) && $params['setDocsForeFilterOnPage'] == $modx->documentIdentifier) {
    $modx->setPlaceholder('eFilter_search_ids', $docs);
}
return $out;
