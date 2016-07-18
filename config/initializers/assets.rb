# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path


# Include all JS files, also those in subdolfer or javascripts assets folder
# includes for exmaple applicant.js. JS isn't the problem so the catch all works.
Rails.application.config.assets.precompile += %w(*.js)
# Replace %w( *.css *.js *.css.scss) with complex regexp avoiding SCSS partials compilation
Rails.application.config.assets.precompile += [/^[^_]\w+\.(css|css.scss)$/]
