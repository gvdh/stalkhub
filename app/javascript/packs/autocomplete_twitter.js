$('.typeahead').typeahead({
  minLength: 3,
  highlight: true
},
{
  name: 'my-dataset',
  source: mySource
});

var myVal = $('.typeahead').typeahead('val');
$('.typeahead').typeahead('val', myVal);
$('.typeahead').typeahead('open');
$('.typeahead').typeahead('close');
$('.typeahead').typeahead('destroy');

var typeahead = jQuery.fn.typeahead.noConflict();
jQuery.fn._typeahead = typeahead;
