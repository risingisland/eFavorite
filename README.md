### eFavorite snippet - generates favorites lists for EvolutionCMS
#### English version

---------

> Author: author [@webber](https://github.com/webber)

> Thanks to [Andrey](https://github.com/0test) for his info and examples.

---------

### SNIPPET PARAMETERS
* **&className** - The name of the handler class. Default value: ```eFavorite```
* **&lifetime** - The lifetime of the cookie. Default value: ```2592000``` = 30 days
* **&elementTotalId** - The ID of the element that displays the total number of favorites. Default value: ```favorits_cnt```
* **&elementClass** - The class of the button element for Adding/Removing from favorites. Default value: ```favorite```. This element must have the ```data-id="[+id+]"``` or ```data-id="[*id*]"``` attribute, to add a document.
* **&elementActiveClass** - The class of the active button element to Add/Remove from favorites. Default value: ```active```
* **&addText** - Tooltip when hovering over an inactive element. Default value: ```Add to wishlist```<br>
* **&removeText** - tooltip when hovering over the active element. Default value: ```Remove from wishlist```<br>
<br>

Вызов осуществляется один раз в шапке сайта (на каждый список), расстановка активных элементов и общего количества производится после ajax-запроса.<br>
Имеет встроенную интеграцию с фильтрацией eFilter - т.е. можно организовать дополнительную фильтрацию избранного по заданным параметрам без дополнительных доработок.<br>

### интеграция с eFilter
&setDocsForeFilterOnPage - если избранные элементы будут фильтроваться с помощью eFilter, то задать id нужной страницы тут.<br>
&eFilterCallback=`1` - если eFilter вызывается в режиме ajax, не забудьте указать данный параметр<br>
<br>

### вызов
[!eFavorite!] - где-нибудь в хидере<br>
сниппет установит плейсхолдер [+eFavoriteDocs+], который в дальнейшем можно использовать в вызовах других сниппетов<br><br>
[!eFavorite? &setDocsForeFilterOnPage=`5`!]<br>
установит дополнительный плейсхолдер [+eFilter_search_ids+] на странице с id=5, который будет использоваться при формировании вывода [!eFilter!]<br><br>

при необходимости вывода списка - можно ПОВТОРНО вызвать в нужном месте с обычными параметрами DocLister<br>
[!eFavorite? &tpl=`@CODE:[+pagetitle+]<hr>`!]<br>

### несколько списков
для организации нескольких списков - избранное, вишлист, сравнение - можно вызывать несколько сниппетов с разными id и разными параметрами
в хидере<br>
[!eFavorite!] //- для организации избранного<br>
[!eFavorite? &id=`wishlist` &elementTotalId=`total` &elementClass=`wishlist` &addText=`добавить в wishlist` &removeText=`удалить из wishlist` &lifetime=`2592002`!] //- для wishlist<br>
<br>
на странице показа избранного дополнительный вызов<br>
[!eFavorite!]<br>
<br>
на странице показа wishlist дополнительный вызов<br>
[!eFavorite? &id=`wishlist`!]<br>
