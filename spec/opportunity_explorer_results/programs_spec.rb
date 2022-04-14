require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do
  describe "programs" do
    context "when the company is well established" do
      context "when all industries selected" do
        before :each do
          visit "/opportunity-explorer-results/index.html?industry=all&revenue=1&purchase=0"
        end

        it "renders" do
          expect(page). to have_content("Your results")
        end

        it "shows multiple available programs" do
          expect(page).to have_content("Multiple Award Schedules (MAS)")
          expect(page).to have_content("Multiple Award Schedules IT (MAS IT)")
          expect(page).to have_content("FASt Lane")
          expect(page).to have_content("Government-wide Acquisition Contracts (GWAC)")
          expect(page).to have_content("Construction and building maintenance")
          expect(page).to have_content("Telecommunications and network services")
        end

        it "does not have any missing info for MAS" do
          expect(page).not_to have_content("You must be in business for 2 years and show $25,000 in revenue to
          become a MAS vendor")
        end
      end

      context "when it is an IT company" do
        it "shows MAS, MAS IT, FASt Lane, and GWAC but not startup springboard programs" do
          visit "/opportunity-explorer-results/index.html?industry=it&revenue=1&purchase=0"
          expect(page).to have_content("Multiple Award Schedules (MAS)")
          expect(page).to have_content("Multiple Award Schedules IT (MAS IT)")
          expect(page).to have_content("FASt Lane")
          expect(page).to have_content("Government-wide Acquisition Contracts (GWAC)")

          expect(page).not_to have_content("Startup Springboard")
        end
      end

      context "when it is a sateliite communications company" do
        it "should display telecommunications IDIQ in addition to other IT opportunities" do
          visit "/opportunity-explorer-results/index.html?industry=itsatcom&revenue=1&purchase=0"
          expect(page).to have_content("Telecommunications and network services")
          expect(page).to have_content("Multiple Award Schedules (MAS)")
          expect(page).to have_content("Multiple Award Schedules IT (MAS IT)")
          expect(page).to have_content("FASt Lane")
          expect(page).to have_content("Government-wide Acquisition Contracts (GWAC)")
        end
      end
      context "when it is a construction and building maintenance company" do
        it "should display construction and building maintenance IDIQ as well as MAS" do
          visit "/opportunity-explorer-results/index.html?industry=construction&revenue=1&purchase=0"
          expect(page).to have_content("Construction and building maintenance")
          expect(page).to have_content("Multiple Award Schedules (MAS)")

          expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
        end
      end
    end

    context "when the company is not well-established" do
      before :each do
        visit "/opportunity-explorer-results/index.html?industry=it&revenue=0&purchase=0"
      end

      it "shows springboard and GWAC programs" do
        expect(page).to have_content("FASt Lane")
        expect(page).to have_content("Startup Springboard")
        expect(page).to have_content("Government-wide Acquisition Contracts (GWAC)")
      end

      it "shows missing requirements for MAS" do
        expect(page).not_to have_content("You must be in business for 2 years and show $25,000 in revenue to
        become a MAS vendor")
      end
    end
  end
end
