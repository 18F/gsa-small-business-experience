require "spec_helper"

describe "/" do
  it "visits the home page" do
    visit "/"
    expect(page.status_code).to be(200)
    expect(page).to have_link("General Services Administration", href: "/")
    expect(page).to have_content("GSA awarded $24 billion dollars to small businesses this year.")
  end
end
