### eFavorite snippet - generates favorites lists for EvolutionCMS
#### English version

---------

> Author: author [@webber12](https://github.com/webber12)

> Thanks to [Andrey](https://github.com/0test) for his info and examples.

---------

### SNIPPET PARAMETERS
* **&id** - Assigns a unique ID to the call. Usful when multiple lists (favorites, wishlist, compare) are being made.
* **&className** - The name of the handler class.  Default value: ```eFavorite```
* **&lifetime** - The lifetime of the cookie. Default value: ```2592000``` = 30 days
* **&elementTotalId** - The ID of the element that displays the total number of favorites. Default value: ```favorits_cnt```
* **&elementClass** - The class of the button element for Adding/Removing from favorites. Default value: ```favorite```. This element must have the ```data-id="[+id+]"``` or ```data-id="[*id*]"``` attribute, to add a document.
* **&elementActiveClass** - The class of the active button element to Add/Remove from favorites. Default value: ```active```
* **&addText** - Tooltip when hovering over an inactive element. Default value: ```Add to wishlist```<br>
* **&removeText** - tooltip when hovering over the active element. Default value: ```Remove from wishlist```<br>
<br>

### Example usage:
1. ```[!eFavorite!]``` - Include in header of the templates you wish to use. This sets the cookie to remember the selection.
1. Create a landing page to display your list of favorates, and include the following in the body where you want to display the listing:
	```[!eFavorite? &tpl=`@CODE:<a href="[~[+id+]~]">[+pagetitle+]</a><hr>`!] ```
1. To display a link that shows the number of selected favorates, along with a link to the landing page, include the following in the desired location of your template (in this example, the landing page has an ID of 50):
	```<a href="[~50~]">Favorites (<span id="favorits_cnt"></span>)</a>```
1. To display the call that allows you to Add/Remove items from favorites, add the following to your articles template:<br>
	```<span class="favorite" data-id="[+id+]" ></span> ```<br>
	or within a page:<br>
	```<span class="favorite" data-id="[*id*]" ></span> ```

   1. You will also want to include the following CSS to display the icons that, when clicked, will show weather the item is selected or not (this example is assuming you are using FontAwesome, but can be modified to fit your needs):<br>

**FontAwesome 4.7**
	```
	.favorite {cursor: pointer;}
	.favorite:hover {text-decoration: underline;}
	.favorite::before {font-family: "FontAwesome"; color: dark-grey; font-size:16px; content: "\f08a";}
	.favorite.active::before {font-family: "FontAwesome"; color: red; font-size:16px; content: "\f004";}
	```

**FontAwesome 5.+**
	```
	.favorite {cursor: pointer;}
	.favorite:hover {text-decoration: underline;}
	.favorite::before {font-family: "Font Awesome 5 Free"; color: dark-grey; font-size:16px; font-weight: 300; content: "\f004";}
	.favorite.active::before {font-family: "Font Awesome 5 Free"; color: red; font-size:16px; font-weight: 900; content: "\f004";}
	```
* A more extensive example for step one:<br>
```[!eFavorite? &id=`wishlist` &elementTotalId=`total` &elementClass=`wishlist` &addText=`Add Favorite` &removeText=`Remove Favorite` &lifetime=`2592002`!]```

**Explination:** <br>
	```&id=`wishlist` ``` has been added for creating a unique call. Usful when multiple lists are being made.<br>
	```&addText=`Add Favorite` &removeText=`Remove Favorite` ``` to modify the button hover texts.<br>
	```&lifetime=`2592002` ``` Cookie life has been extended.<br>
	```&elementClass=`wishlist` ``` Unique css class has been added.<br>
	
---------

#### Alternative Modifications:<br>
**File:** ```\assets\snippets\eFavorite\js\eFavorite.js```<br>
* Display the number zero when nothing has been selected, update line 31:<br>
```if (total == 0) total = '0';```

* Use the ```&addText``` & ```&removeText``` as button selectors and not css, update lines 34 & 36 with the following:<br>
```
$("." + self.params.elementClass).html(self.params.addText);
```

```
$("." + self.params.elementClass + "[data-id='" + rows[key].id + "']").html(self.params.removeText);
```