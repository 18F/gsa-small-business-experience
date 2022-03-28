require "spec_helper"

describe "/opportunity-explorer" do

  before :each do
    visit "/opportunity-explorer/index.html"
  end

  it "has code 200" do
    expect(page.status_code).to be(200)
  end

  it "has navigation links" do
    expect(page).to have_link("General Services Administration", href: "/")
    # expect(page).to have_link("TODO breadcrumbs")
  end

  it "built questions from the YAML file" do
    expect(page).to have_css("legend", count: 4)
    expect(page).to have_css("#industry option", count: 9)
    expect(page).to have_css("#sdvob")
    expect(page).to have_css("label", text: "Service-Disabled Veteran-Owned Business")
    expect(page).to have_button("Submit")
  end
end
