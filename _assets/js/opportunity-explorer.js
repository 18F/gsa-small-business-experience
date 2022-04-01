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

  const programDivs = document.getElementById("programs").children;

  for (let program of programDivs) {
    let programRules = rules[program.id];
    let alwaysDisplay = programRules["alwaysDisplay"]

    let industryMatch = programRules["industry"].includes(industry);
    let revenueMatch = checkRule(programRules["revenue"], revenue);

    if (alwaysDisplay) {
      // if the program is being displayed, check if its individual criteria
      // for revenue and purchase have been met and if so, hide those warnings
      if (revenueMatch) { hideWarning("revenue", program.id); }
    } else if (!industryMatch || !revenueMatch) {
      program.classList.add("display-none");
    }
  }

  function checkRule(rule, param) {
    // if the rule is null then this particular question does not apply
    return (rule == null) ? true : (rule == param)
  }

  function hideWarning(type, programId) {
    let warning = document.getElementById(programId + "-" + type);
    if (warning) { warning.classList.add("display-none"); }
  }

  // CONTRACT EXAMPLES

  // Hide any contracts which are not from the selected industry

  // TODO what to display if no industry selected?
  // TODO skip iterating through each and hide table if none selected?
  contractDivs = document.getElementById("contracts").children;
  for (let row of contractDivs) {
    if (!row.classList.contains("contract-" + industry)) {
      row.classList.add("display-none");
    }
  }
});
