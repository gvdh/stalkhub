document.addEventListener("DOMContentLoaded", () => {

  category_filter = document.getElementById("category_filter");
  categoryButtons = category_filter.querySelectorAll(".filter-btn");

  // Default "settings" when we arrive on results view
  all = document.getElementById("all");
  all.classList.add("active");

  btnTo = document.getElementById('to');
  btnFrom = document.getElementById('from');

  results = document.querySelectorAll('#result_card');

  // When we click on all btn, all hidden will be remove
  document.getElementById('all').addEventListener ("click", (event) => {
    results.forEach((result) => {
      result.classList.remove("hidden");
      });
    })


  btnFrom.addEventListener("click", (event) => {
    results.forEach((result) => {
      btnFrom.classList.add('active');
      all.classList.remove("active");
      btnTo.classList.remove("active");
      if (result.classList.contains("twitter-from")) {
        result.classList.remove("hidden");
      } else {
        result.classList.add("hidden");
      };
    });
  })


  btnTo.addEventListener("click", (event) => {
    results.forEach((result) => {
      btnTo.classList.add('active');
      all.classList.remove("active");
      btnFrom.classList.remove('active');
      if (result.classList.contains("twitter-to")) {
        result.classList.remove("hidden");
      } else {
        result.classList.add("hidden");
      };
    })
  });

});
