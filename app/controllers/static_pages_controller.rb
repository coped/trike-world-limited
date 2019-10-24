class StaticPagesController < ApplicationController
    def home
    end

    def about
    end

    def contact
    end

    # Actions for gallery pages

    def charles
        render action: 'galleries/charles'
    end

    def tim
        render action: 'galleries/tim'
    end

    def red_trike
        render action: 'galleries/red_trike'
    end

    def roth_body
        render action: 'galleries/roth_body'
    end

    def twin_turbo
        render action: 'galleries/twin_turbo'
    end

    def misc
        render action: 'galleries/misc'
    end
end
