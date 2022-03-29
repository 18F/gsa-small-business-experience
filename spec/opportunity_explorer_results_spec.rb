require "spec_helper"

describe "/opportunity-explorer-results", type: :feature, js: true do

  # NO SELECTIONS

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
        expect(page).to have_content("Programs")
      end

      it "does not have any programs" do
        expect(page).not_to have_content("Multiple Award Schedules (MAS)")
        expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
      end
    end

    describe "consistent sections" do
      it "does have other opportunities" do
        expect(page).to have_content("Subcontracting & Partnerships")
        expect(page).to have_content("Open Market Opportunities")
        expect(page).to have_content("Explore Contracts & Complete Market Analysis")
      end
    end
  end

  # SET ASIDES

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

  # PROGRAMS

  context "when a company sells higher than the micro-purchase threshold" do
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
        it "should display construction and building maintenance IDIQ" do
          visit "/opportunity-explorer-results/index.html?industry=construction&revenue=1&purchase=0"
          expect(page).to have_content("Construction and building maintenance")

          expect(page).not_to have_content("Multiple Award Schedules (MAS)")
          expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
        end
      end
    end

    context "when the company is not well-established" do
      it "shows springboard and GWAC programs" do
        visit "/opportunity-explorer-results/index.html?industry=it&revenue=0&purchase=0"
        expect(page).to have_content("FASt Lane")
        expect(page).to have_content("Startup Springboard")
        expect(page).to have_content("Government-wide Acquisition Contracts (GWAC)")
      end
    end
  end

  context "when a company sells only micropurchases" do
    context "and they are well-established" do
      context "when industry not selected" do
        it "shows no program results" do
          visit "/opportunity-explorer-results/index.html?industry=all&revenue=1&purchase=1"
          expect(page).not_to have_content("Multiple Award Schedules (MAS)")
          expect(page).not_to have_content("Multiple Award Schedules IT (MAS IT)")
          expect(page).not_to have_content("FASt Lane")
          expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
          expect(page).not_to have_content("Construction and building maintenance")
          expect(page).not_to have_content("Telecommunications and network services")
        end
      end
      context "when industry is IT" do
        it "shows no program results" do
          visit "/opportunity-explorer-results/index.html?industry=it&revenue=1&purchase=1"
          expect(page).not_to have_content("Multiple Award Schedules (MAS)")
          expect(page).not_to have_content("Multiple Award Schedules IT (MAS IT)")
          expect(page).not_to have_content("FASt Lane")
          expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
          expect(page).not_to have_content("Construction and building maintenance")
          expect(page).not_to have_content("Telecommunications and network services")
        end
      end
    end
    context "and they are not well-established" do
      it "shows no program results" do
        visit "/opportunity-explorer-results/index.html?industry=all&revenue=0&purchase=1"
        expect(page).not_to have_content("Multiple Award Schedules (MAS)")
        expect(page).not_to have_content("Multiple Award Schedules IT (MAS IT)")
        expect(page).not_to have_content("FASt Lane")
        expect(page).not_to have_content("Government-wide Acquisition Contracts (GWAC)")
        expect(page).not_to have_content("Construction and building maintenance")
        expect(page).not_to have_content("Telecommunications and network services")
      end
    end
  end
end
