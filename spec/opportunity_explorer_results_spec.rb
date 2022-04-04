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

      it "does not have any programs except MAS" do
        expect(page).to have_content("Multiple Award Schedules (MAS)")
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

  # CONTRACTS

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
        expect(page).to have_content("Web Site Hosting")
        expect(page).to have_content("Ink Toner Boxes")
        expect(page).to have_content("Hotel Accommodations/Lodging")
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
