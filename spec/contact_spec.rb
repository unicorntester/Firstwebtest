require 'spec_helper'

describe "Contact page" do
    before do
        # Navigate to Page    
        cookies.clear
        goto 'juice-shop-buggy.herokuapp.com'

        # Dismiss OWASP popup
        button(css: "app-welcome-banner button.mat-primary").when_present.click
        element(class: "cdk-overlay-backdrop").wait_while(&:exists?)
    end

    it "should be avalilable from hamburger menu" do
        button(css:'mat-toolbar button[aria-label="Open Sidenav"]').click
        link(css: 'sidenav a[routerlink="/contact"]').click
        # alternatywnie: element(tag_name: "sidenav").link(visible_text: /Customer Feedback/).click
        wait_until do
            element(id:"feedback-form").present?
        end
    end

    it "can't be submited without captcha" do
        goto "http://juice-shop-buggy.herokuapp.com/#/contact"
        textarea(id:'comment').set 'Hakuna matata. Bad shop'
        element(tag_name: "bar-rating").element(class: "br-unit", index: 1).click
        expect(button(id: "submitButton")).to be_disabled
    end

    it "check what is going on when captcha is bad" do
        goto "http://juice-shop-buggy.herokuapp.com/#/contact"
        textarea(id:'comment').set 'This shop is better than unicorns.'
        text_field(id:'captchaControl').set 'Enter here sth'
        element(tag_name: "bar-rating").element(class: "br-unit", index: 4).click
        expect(element(visible_text: 'Invalid CAPTCHA code')).to be_present
        expect(button(id: "submitButton")).to be_disabled
    end
end

