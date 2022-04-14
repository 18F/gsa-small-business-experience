require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do
  describe "industry" do
    context "when an industry is not selected" do
      before :each do
        visit "/opportunity-explorer-results/index.html?industry="
      end

      it "renders" do
        expect(page).to have_content("Current and past contracts")
      end

      it "does not include any industry information under contracts" do
        expect(page).not_to have_content("Current and past contracts for")
      end
    end

    context "when an industry is selected" do
      context "and the industry is science" do
        it "includes the science industry label twice" do
          visit "/opportunity-explorer-results/index.html?industry=science"
          expect(page).to have_content("Current and past contracts for \"Scientific management & solutions\"")
          expect(page).to have_content("Upcoming opportunities for \"Scientific management & solutions\"")
        end
      end
      context "and the industry is itsatcom" do
        it "includes the itsatcom industry label twice" do
          visit "/opportunity-explorer-results/index.html?industry=itsatcom"
          expect(page).to have_content("Current and past contracts for \"IT: communications and satellite\"")
          expect(page).to have_content("Upcoming opportunities for \"IT: communications and satellite\"")
        end
      end
    end
  end
end
