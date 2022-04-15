require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do
  describe "contracts" do
    context "when no industry is selected" do
      it "hides the table with contracts" do
        visit "/opportunity-explorer-results/index.html?industry="
        expect(page).not_to have_content("Contract Title")
      end
    end

    context "when industry is selected" do
      context "and industry is all" do
        before :each do
          visit "/opportunity-explorer-results/index.html?industry=all"
        end
        it "shows contracts from a range of disciplines" do
          expect(page).to have_content("Diversity, Equity, Inclusion, and Accessibility Training")
          expect(page).to have_content("LABOR, DEPT OF")
          expect(page).to have_content("Ink Toner Boxes")
          expect(page).to have_content("VETERANS AFFAIRS, DEPT OF")
          expect(page).to have_content("Hotel Accommodations/Lodging")
          expect(page).to have_content("JUSTICE, DEPT OF")
        end
        it "does not show those contracts that should be hidden" do
          expect(page).not_to have_content("Mount Rushmore Custodial Services")
          expect(page).not_to have_content("Port of Entry Project - A/E Services")
          expect(page).not_to have_content("Large Format Production Printer")
        end
      end

      context "and industry is architecture" do
        before :each do
          visit "/opportunity-explorer-results/index.html?industry=architecture"
        end
        it "shows contracts for architecture" do
          expect(page).to have_content("Supplemental Architecture and Engineering Services for OK")
          expect(page).to have_content("Design-Build Construction of Plant Biosence Research Facility, WA")
        end
        it "does not show unrelated industry contracts" do
          expect(page).not_to have_content("300 MhZ Solid-State NMR Spectrometer Console")
          expect(page).not_to have_content("NP Aerospace Bomb Suits")
        end
        it "has two contract results" do
          expect(page).to have_css("tr.contract", count: 2)
        end
      end

      context "and industry is itsatcom" do
        before :each do
          visit "/opportunity-explorer-results/index.html?industry=itsatcom"
        end
        it "shows contracts for itsatcom" do
          expect(page).to have_content("Cellular telephone services")
          expect(page).to have_content("Notice of Intent to Solicit and Award Contract for Beeper Services")
          expect(page).to have_content("Tactical Network Routers")
        end
        it "does not show unrelated industry contracts" do
          expect(page).not_to have_content("PM/CM Engineering Support for VACCHCS IAW")
          expect(page).not_to have_content("Horse Mountain Wildlife Water Catchment")
        end
        it "has three contract results" do
          expect(page).to have_css("tr.contract", count: 3)
        end
      end
    end
  end
end
