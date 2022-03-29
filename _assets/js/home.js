document.addEventListener("DOMContentLoaded", function(){

  const tabButtons = document.querySelectorAll("#wtw-nav button");
  const tabPanels = document.querySelectorAll("#wtw-tab-panels .panel")

  for (let button of tabButtons) {
    button.addEventListener("click", function() {
      toggleTabs(this.id);
    })
  }

  function toggleTabs(buttonId) {
    let tabPanelId = buttonId + "-tab";

    tabButtons.forEach(btn => {
      btn.classList.remove("active");
      btn.ariaSelected = "false";
    })
    tabPanels.forEach(panel => {
      panel.classList.add("display-none");
      panel.ariaHidden = "true";
    })
    selectedTab = document.getElementById(buttonId);
    selectedTab.classList.add("active");
    selectedTab.ariaSelected = "true";

    selectedPanel = document.getElementById(buttonId + "-tab");
    selectedPanel.classList.remove("display-none");
    selectedPanel.ariaHidden = "false";
  }
});
