document.addEventListener("DOMContentLoaded", () => {
  category_filter = document.getElementById("category_filter")
  categoryButtons = category_filter.querySelectorAll(".filter-btn")

  privacy_filter = document.getElementById("privacy-filter")
  privacyButtons = privacy_filter.querySelectorAll(".filter-btn")

  results = document.querySelectorAll("#result_card")

  // Default "settings" when we arrive on results view
    nofilters = document.getElementById("nofilters")
    nofilters.classList.add("active");

    all = document.getElementById("all");
    all.classList.add("active");

    results.forEach((result) => {
      result.classList.remove("hidden");
    });

  // NB : No privacy filter on pages and photos
  // TODO : refactor when we have time (without breaking everything :D)

  // privacy filter
  everyone = document.getElementById("everyone")
  everyone.addEventListener("click", (event) => {
    privacyButtons.forEach((button) => {
      button.classList.remove("active")
    });
    everyone.classList.add("active");

    activeFilter = category_filter.querySelector(".active").id
    if (!(activeFilter === "all")) {
      activeFilter = activeFilter.slice(0,-1)
    }

    results.forEach((result) => {
      if ((result.classList.contains("EVERYONE") && (result.classList.contains(activeFilter) || activeFilter === "all"))) {
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  friends = document.getElementById("friends")
  friends.addEventListener("click", (event) => {
    privacyButtons.forEach((button) => {
      button.classList.remove("active")
    });
    friends.classList.add("active");

    category_filter = document.getElementById("category_filter")
    activeFilter = category_filter.querySelector(".active").id
    if (!(activeFilter === "all")) {
      activeFilter = activeFilter.slice(0,-1)
    }

    results.forEach((result) => {
      if ((result.classList.contains("ALL_FRIENDS") && (result.classList.contains(activeFilter) || activeFilter === "all"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  myself = document.getElementById("myself")
  myself.addEventListener("click", (event) => {
    privacyButtons.forEach((button) => {
      button.classList.remove("active")
    });
    myself.classList.add("active");

    activeFilter = category_filter.querySelector(".active").id
    if (!(activeFilter === "all")) {
      activeFilter = activeFilter.slice(0,-1)
    }

    results.forEach((result) => {
      if ((result.classList.contains("SELF") && (result.classList.contains(activeFilter) || activeFilter === "all"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  nofilters = document.getElementById("nofilters")
  nofilters.addEventListener("click", (event) => {
    privacyButtons.forEach((button) => {
      button.classList.remove("active")
    });
    nofilters.classList.add("active");

    activeFilter = category_filter.querySelector(".active").id
    if (!(activeFilter === "all")) {
      activeFilter = activeFilter.slice(0,-1)
    }

    results.forEach((result) => {
      if ((result.classList.contains(activeFilter) || activeFilter === "all")){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  // category filter
  all = document.getElementById("all")
  all.addEventListener("click", (event) => {
    categoryButtons.forEach((button) => {
      button.classList.remove("active")
    });
    all.classList.add("active");

    activeFilter = privacy_filter.querySelector(".active").id
    if (activeFilter === "nofilters") {
      activeFilter = "nofilters"
    } else if (activeFilter === "myself") {
      activeFilter = "SELF"
    } else if (activeFilter === "friends") {
      activeFilter = "ALL_FRIENDS"
    } else if (activeFilter === "everyone") {
      activeFilter = "EVERYONE"
    }

    results.forEach((result) => {
      if ((result.classList.contains(activeFilter) || activeFilter === "nofilters")){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  });

  photos = document.getElementById("photos")
  photos.addEventListener("click", (event) => {
    categoryButtons.forEach((button) => {
      button.classList.remove("active")
    });
    photos.classList.add("active");

    activeFilter = privacy_filter.querySelector(".active").id
    if (activeFilter === "nofilters") {
      activeFilter = "nofilters"
    } else if (activeFilter === "myself") {
      activeFilter = "SELF"
    } else if (activeFilter === "friends") {
      activeFilter = "ALL_FRIENDS"
    } else if (activeFilter === "everyone") {
      activeFilter = "EVERYONE"
    }

    results.forEach((result) => {
      if ((result.classList.contains("photo") && (result.classList.contains(activeFilter) || activeFilter === "nofilters"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  videos = document.getElementById("videos")
  videos.addEventListener("click", (event) => {
    categoryButtons.forEach((button) => {
      button.classList.remove("active")
    });
    videos.classList.add("active");

    activeFilter = privacy_filter.querySelector(".active").id
    if (activeFilter === "nofilters") {
      activeFilter = "nofilters"
    } else if (activeFilter === "myself") {
      activeFilter = "SELF"
    } else if (activeFilter === "friends") {
      activeFilter = "ALL_FRIENDS"
    } else if (activeFilter === "everyone") {
      activeFilter = "EVERYONE"
    }

    results.forEach((result) => {
      if ((result.classList.contains("video") && (result.classList.contains(activeFilter) || activeFilter === "nofilters"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })

  posts = document.getElementById("posts")
  posts.addEventListener("click", (event) => {
    categoryButtons.forEach((button) => {
      button.classList.remove("active")
    });
    posts.classList.add("active");

    activeFilter = privacy_filter.querySelector(".active").id
    if (activeFilter === "nofilters") {
      activeFilter = "nofilters"
    } else if (activeFilter === "myself") {
      activeFilter = "SELF"
    } else if (activeFilter === "friends") {
      activeFilter = "ALL_FRIENDS"
    } else if (activeFilter === "everyone") {
      activeFilter = "EVERYONE"
    }

    results.forEach((result) => {
      if ((result.classList.contains("post") && (result.classList.contains(activeFilter) || activeFilter === "nofilters"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    })
  })


  pages = document.getElementById("pages")
  pages.addEventListener("click", (event) => {
    categoryButtons.forEach((button) => {
      button.classList.remove("active")
    });
    pages.classList.add("active");

    activeFilter = privacy_filter.querySelector(".active").id
    if (activeFilter === "nofilters") {
      activeFilter = "nofilters"
    } else if (activeFilter === "myself") {
      activeFilter = "SELF"
    } else if (activeFilter === "friends") {
      activeFilter = "ALL_FRIENDS"
    } else if (activeFilter === "everyone") {
      activeFilter = "EVERYONE"
    }

    results.forEach((result) => {
      if ((result.classList.contains("page") && (result.classList.contains(activeFilter) || activeFilter === "nofilters"))){
        result.classList.remove("hidden")
      } else {
        result.classList.add("hidden")
      };
    });
  });


  // reverse button
  reverse = document.getElementById("reverse")
  reverse.addEventListener("click", (event) => {
   categoryButtons.forEach((button) => {
     button.classList.remove("active")
   });
   reverse.classList.add("active");
  })

});
