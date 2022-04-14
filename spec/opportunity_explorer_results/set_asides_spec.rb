require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do
  describe "setasides" do
    context "when different setasides have been selected" do
      context "when all are selected" do
        before :each do
          visit "/opportunity-explorer-results/index.html?setasides=wosb&setasides=sdb8a&setasides=hubzone&setasides=sdvob"
        end

        it "renders" do
          expect(page).to have_content("Your results")
        end

        it "shows all the set-asides" do
          expect(page).to have_content("Women-Owned Small Businesses")
          expect(page).to have_content("Historically Underutilized Business Zones (HUBZone)")
          expect(page).to have_content("Service-Disabled Veteran-Owned Business")
          expect(page).to have_content("Small Disadvantaged Businesses 8(a)")
        end
      end

      context "when only one is selected" do
        before :each do
          visit "/opportunity-explorer-results/index.html?setasides=wosb"
        end

        it "renders" do
          expect(page).to have_content("Your results")
        end

        it "shows only the specified set-asides" do
          expect(page).to have_content("Women-Owned Small Businesses")
          expect(page).not_to have_content("Historically Underutilized Business Zones (HUBZone)")
          expect(page).not_to have_content("Service-Disabled Veteran-Owned Business")
          expect(page).not_to have_content("Small Disadvantaged Businesses 8(a)")
        end
      end

      context "when two are selected" do
        before :each do
          visit "/opportunity-explorer-results/index.html?setasides=wosb&setasides=sdvob"
        end

        it "renders" do
          expect(page).to have_content("Your results")
        end

        it "shows the two selected the set-asides" do
          expect(page).to have_content("Women-Owned Small Businesses")
          expect(page).not_to have_content("Historically Underutilized Business Zones (HUBZone)")
          expect(page).to have_content("Service-Disabled Veteran-Owned Business")
          expect(page).not_to have_content("Small Disadvantaged Businesses 8(a)")
        end
      end

      context "when three are selected" do
        before :each do
          visit "/opportunity-explorer-results/index.html?setasides=wosb&setasides=sdb8a&setasides=hubzone"
        end

        it "renders" do
          expect(page).to have_content("Your results")
        end

        it "shows the three selected set-asides" do
          expect(page).to have_content("Women-Owned Small Businesses")
          expect(page).to have_content("Historically Underutilized Business Zones (HUBZone)")
          expect(page).not_to have_content("Service-Disabled Veteran-Owned Business")
          expect(page).to have_content("Small Disadvantaged Businesses 8(a)")
        end
      end
    end
  end
end