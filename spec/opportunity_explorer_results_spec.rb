require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do

  context "with no selections" do
    before :each do
      visit "/opportunity-explorer-results/index.html"
    end
    
    it "renders" do
      expect(page).to have_content "Your results"
    end

    it "has navigation links" do
      expect(page).to have_link("General Services Administration", href: "/")
      # TODO breadcrumbs
    end

    it "built answers from the YAML file" do
      expect(page).to have_link("General Services Administration", href: "/")

      expect(page).not_to have_content("Women-Owned Small Businesses")
      expect(page).not_to have_css("div.setaside", count: 4)
      expect(page).not_to have_css("#hubzone")
      expect(page).not_to have_css("h3", text: "Historically Underutilized Business Zones (HUBZone)")
      expect(page).not_to have_content("My business's principal office is located in a HUBZone")

      # TODO add in programs
    end
  end

  context "when different setasides have been selected" do
    it "displays all when all selected" do
      visit "/opportunity-explorer-results/index.html"
    end
  end
end
