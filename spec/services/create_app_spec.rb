require 'spec_helper'

describe CreateApp do
  let(:current_admin) { create(:admin) }
  let(:name) { "An app" }
  let(:create_app) {
    CreateApp.call(
      current_admin: current_admin,
      name: name,
      open_tracking_enabled: false,
      click_tracking_enabled: false,
      custom_tracking_domain: nil,
      from_domain: "foo.com"
    )
  }

  it "should create an app" do
    expect { create_app }.to change { App.count }.by(1)
  end

  it "should return the created app" do
    app = create_app.result
    expect(app.name).to eq "An app"
    expect(app.open_tracking_enabled).to eq false
    expect(app.click_tracking_enabled).to eq false
    expect(app.custom_tracking_domain).to be_nil
    expect(app.from_domain).to eq "foo.com"
  end

  it "should create the app in the same team as the admin" do
    expect(create_app.result.team).to eq current_admin.team
  end

  it "should be successfull" do
    expect(create_app).to be_success
  end
end