require "spec_helper"

describe "/opportunity-explorer-results" do

  # before :each do
  #   visit "/opportunity-explorer/index.html"
  # end

  it "has code 200" do
    visit "/opportunity-explorer-results/index.html"
    expect(page.status_code).to be(200)
  end

  it "has navigation links" do
    visit "/opportunity-explorer-results/index.html"
    expect(page).to have_link("General Services Administration", href: "/")
    # expect(page).to have_link("TODO breadcrumbs")
  end

  it "built answers from the YAML file" do
    visit "/opportunity-explorer-results/index.html"

    puts page.body

    expect(page).not_to have_css("div.setaside", count: 4)
    expect(page).not_to have_css("#hubzone")
    expect(page).not_to have_css("h3", text: "Historically Underutilized Business Zones (HUBZone)")
    expect(page).not_to have_content("My business's principal office is located in a HUBZone")

    # TODO add in programs
  end

  context "when different setasides have been selected" do
    it "displays all when all selected" do
      visit "/opportunity-explorer-results/index.html"
    end
  end
end
