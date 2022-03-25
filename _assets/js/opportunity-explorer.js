document.addEventListener("DOMContentLoaded", function(){
  const uri = new URL(window.location.href);
  const params = uri.searchParams;


  // start with all the options displayed, then hide non-relevant items
  // so that in the absence of JS users will be able to access the content


  // SETASIDES

  // Hide all setasides that the user did not indicate were relevant to them

  const setasides = params.getAll("setasides");
  const setaside_divs = document.getElementById("setasides").children;

  for (let ele of setaside_divs) {
    if (!setasides.includes(ele.id)) {
      ele.style.display = "none";
    }
  }});
