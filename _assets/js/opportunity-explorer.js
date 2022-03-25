document.addEventListener("DOMContentLoaded", function(){
  const uri = new URL(window.location.href);
  const params = uri.searchParams;


  // start with all the options displayed, then hide non-relevant items
  // so that in the absence of JS users will be able to access the content

  // SETASIDES

  // Hide all setasides that the user did not indicate were relevant to them

  const setasides = params.getAll("setasides");
  const setasideDivs = document.getElementById("setasides").children;

  for (let ele of setasideDivs) {
    if (!setasides.includes(ele.id)) {
      ele.classList.add("display-none");
    }
  }

  // PROGRAMS

  // Use combinations of parameters to evaluate whether to display a program
  // and hide all those that are not relevant to the selections

  const industry = params.get("industry");
  const revenue = params.get("revenue") == "1";
  const purchase = params.get("purchase") == "1";

  const rules = {
    "mas" : {
      "industry" : [
        "human",
        "it",
        "itsatcom",
        "itemerging",
        "prof"
      ],
      "revenue" : true,
      "purchase" : false
    },
    "masit" : {
      "industry" : ["it", "itsatcom", "itemerging"],
      "revenue" : true,
      "purchase" : false
    },
    "fastlane" : {
      "industry" : ["it", "itsatcom", "itemerging"],
      // TODO does your past performance matter for FAStlane?
      "revenue" : null,
      "purchase" : false,
    },
    "springboard" : {
      "industry" : ["it", "itsatcom", "itemerging"],
      "revenue" : false,
      "purchase" : false,
    },
    "gwac" : {
      "industry" : ["it", "itsatcom", "itemerging"],
      // TODO does it matter how much revenue / past performance your business has
      // to apply to a GWAC?
      "revenue" : null,
      "purchase" : false,
    },
    "construction" : {
      "industry" : [
        "architecture",
        "construction",
        "facilities",
        "furniture",
        "interior",
        "real estate"
      ],
      "revenue" : false,
      "purchase" : false,
    },
    "communications" : {
      "industry" : ["itsatcom"],
      "revenue" : false,
      "purchase" : false,
    }
  }

  const programDivs = document.getElementById("programs").children;

  for (let program of programDivs) {
    let programRules = rules[program.id];

    let industryMatch = programRules["industry"].includes(industry);
    let revenueMatch = checkRule(programRules["revenue"], revenue);
    let purchaseMatch = checkRule(programRules["purchase"], purchase);

    if (!industryMatch || !revenueMatch || !purchaseMatch) {
      program.style.display = "none";
    }
  }

  function checkRule(rule, param) {
    // if the rule is null then this particular question does not apply
    return (rule == null) ? true : (rule == param)
  }
});
