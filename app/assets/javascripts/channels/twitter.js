var options = {

  // Item elements
  items: '*',

  // Default show animation
  showDuration: 300,
  showEasing: 'ease',

  // Default hide animation
  hideDuration: 300,
  hideEasing: 'ease',

  // Item's visible/hidden state styles
  visibleStyles: {
    opacity: '1',
    transform: 'scale(1)'
  },
  hiddenStyles: {
    opacity: '0',
    transform: 'scale(0.5)'
  },

  // Layout
  layout: {
    fillGaps: true,
    horizontal: false,
    alignRight: false,
    alignBottom: false,
    rounding: true
  },
  layoutOnResize: 100,
  layoutOnInit: true,
  layoutDuration: 300,
  layoutEasing: 'ease',

  // Sorting
  sortData: null,

  // Drag & Drop
  dragEnabled: false,
  dragContainer: null,
  dragStartPredicate: {
    distance: 0,
    delay: 0,
    handle: false
  },
  dragAxis: null,
  dragSort: true,
  dragSortInterval: 100,
  dragSortPredicate: {
    threshold: 50,
    action: 'move'
  },
  dragReleaseDuration: 300,
  dragReleaseEasing: 'ease',
  dragHammerSettings: {
    touchAction: 'none'
  },

  // Classnames
  containerClass: 'muuri',
  itemClass: 'muuri-item',
  itemVisibleClass: 'muuri-item-shown',
  itemHiddenClass: 'muuri-item-hidden',
  itemPositioningClass: 'muuri-item-positioning',
  itemDraggingClass: 'muuri-item-dragging',
  itemReleasingClass: 'muuri-item-releasing'

}


App.cable.subscriptions.create({channel: "TwitterChannel", id: "1"},
{
  connected: function() {
    console.log('connected');
  },
  disconnected: function() {
    console.log('disconnected');
  },
  received: function(data) {
    var grid = document.querySelector('.grid');
    var noResults = document.querySelector('.no-results');

    if (noResults) {
      grid.removeChild(noResults);
    }

    grid.insertAdjacentHTML('afterbegin', data);
    new Muuri('.grid', options);

    setTimeout(function () {
      new Muuri('.grid', options);
    }, 1000);
  }
});
