(function () {
  var filterButtons = document.querySelectorAll('[data-filter]');
  var feedItems = document.querySelectorAll('.feed-item');

  if (!filterButtons.length) return;

  filterButtons.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var filter = this.dataset.filter;

      filterButtons.forEach(function (b) {
        b.classList.remove('active');
      });
      this.classList.add('active');

      feedItems.forEach(function (item) {
        if (filter === 'all' || item.dataset.tag === filter) {
          item.hidden = false;
        } else {
          item.hidden = true;
        }
      });
    });
  });
}());
