document.addEventListener("DOMContentLoaded", function(){
  const uri = new URL(window.location.href);
  const params = uri.searchParams;
  const industry = params.get("industry");
  const revenue = params.get("revenue") == "1";
  const setasides = params.getAll("setasides");

  setIndustryLabel(industry);

  // start with all the options displayed, then hide non-relevant items
  // so that in the absence of JS users will be able to access the content
  hideContracts(industry);
  hidePrograms(industry, revenue);
  hideSetAsides(setasides);
});

function checkRule(rule, param) {
  // if the rule is null then this particular question does not apply
  return (rule == null) ? true : (rule == param)
}

// Hide any contracts which are not from the selected industry
// If no industry is selected, hide all contracts
function hideContracts(industry) {
  if (industry == "") {
    document.getElementById("contracts-table").classList.add("display-none");
  } else {
    let contractDivs = document.getElementById("contracts").children;
    for (let row of contractDivs) {
      if (!row.classList.contains("contract-" + industry)) {
        row.classList.add("display-none");
      }
    }
  }
}

// Use combinations or parameters to evaluate whether to display a program
// and hide all those that are not relevant to the selections
function hidePrograms(industry, revenue) {
  const programDivs = document.getElementById("programs").children;

  for (let program of programDivs) {
    let programRules = rules[program.id];
    let alwaysDisplay = programRules["alwaysDisplay"]

    let industryMatch = programRules["industry"].includes(industry);
    let revenueMatch = checkRule(programRules["revenue"], revenue);

    if (alwaysDisplay) {
      // if the program is being displayed, check if its individual criteria
      // for revenue has been met and if so, hide the warning
      if (revenueMatch) { hideWarning("revenue", program.id); }
    } else if (!industryMatch || !revenueMatch) {
      program.classList.add("display-none");
    }
  }
}

// Hide all setasides that the user did not indicate were relevant to them
function hideSetAsides(setasides) {
  const setasideDivs = document.getElementById("setasides").children;
  for (let ele of setasideDivs) {
    if (!setasides.includes(ele.id)) {
      ele.classList.add("display-none");
    }
  }
}

function hideWarning(type, programId) {
  let warning = document.getElementById(programId + "-" + type);
  if (warning) { warning.classList.add("display-none"); }
}

// fill in the industry label where required in the text based on the
// option selected in the quiz
function setIndustryLabel(industry) {
  const selectedIndustry = industries.find(item => item.value == industry)
  if (selectedIndustry) {
    let label = selectedIndustry.label;
    document
      .querySelectorAll(".industry-name")
      .forEach(item => item.innerHTML = "for \"" + label + "\"");
  }
}
