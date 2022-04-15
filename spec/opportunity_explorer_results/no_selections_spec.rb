require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do
  context "with no test selections" do
    before :each do
      visit "/opportunity-explorer-results/index.html"
    end
    
    it "renders" do
      expect(page).to have_content("Your results")
    end

    it "has navigation links" do
      expect(page).to have_link("General Services Administration", href: "/")
      # TODO breadcrumbs
    end

    describe "set-asides" do
      it "does have a set-aside block" do
        expect(page).to have_content("See all set-aside opportunities")
      end

      it "does not have any set-asides" do
        expect(page).not_to have_content("Women-Owned Small Businesses")
        expect(page).not_to have_content("Historically Underutilized Business Zones (HUBZone)")
        expect(page).not_to have_content("Service-Disabled Veteran-Owned Business")
        expect(page).not_to have_content("Small Disadvantaged Businesses 8(a)")
      end
    end

    describe "programs" do
      it "does have a program header" do
        expect(page).to have_content("Become a GSA vendor")
      end

      it "does not have any programs except MAS" do
        expect(page).to have_content("Multiple Award Schedules (MAS)")
        expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
      end
    end

    describe "consistent sections" do
      it "has three steps" do
        expect(page).to have_content("Step 1: Research contracts in your industry")
        expect(page).to have_content("Step 2: Explore ways to sell as a small business")
        expect(page).to have_content("Step 3: Connect with OSDBU")
      end
      it "has non-schedule opportunities" do
        expect(page).to have_content("Become a subcontractor")
        expect(page).to have_content("Explore open market opportunities")
      end
    end
  end
end
