require 'spec_helper'

describe "Login form" do
    before do
        # Navigate to Page    
        cookies.clear
        goto 'juice-shop-buggy.herokuapp.com'

        # Dismiss OWASP popup
        button(css: "app-welcome-banner button.mat-primary").when_present.click
        element(class: "cdk-overlay-backdrop").wait_while(&:exists?)
        
        # Open login page
        button(id: "navbarAccount").when_present.click
        button(id: "navbarLoginButton").when_present.click                
    end

    it "should fail on invalid data" do
        text_field(id: 'email').set 'tyranozaur.fajny.jest@dino.it'
        text_field(id: 'password').set 'adminsrules'
        button(id: 'loginButton').click
        wait_until do
            text.include?('Invalid email or password.')
        end
    end
    it "should pass, good data" do
        text_field(id: 'email').set 'miau.miau@ko.ci'
        text_field(id: 'password').set 'Admin1'
        button(id: 'loginButton').click
        wait_until do
            text.include?('Your Basket')
        end
    end
end

