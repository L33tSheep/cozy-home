BaseModel = require("models/models").BaseModel
client = require "lib/request"

# Describes an application installed in mycloud.
class exports.Application extends BaseModel

    url: '/api/applications/'

    constructor: (app) ->
        super()
        @slug = app.slug
        @name = app.name
        @description = app.description
        @icon = app.icon
        @git = app.git
        @state = app.state
        @
        

    # Send to server installation request.
    # Will create a new app in the database.
    install: (callbacks) ->
        data =
            name: @name
            description: @description
            git: @git

        client.post '/api/applications/install', data,
            success: (data) =>
                @slug = data.app.slug
                @state = data.app.state
                callbacks.success data
            error: callbacks.error

    # Send to server uninstallation request.
    # Will delete the app in the database.
    uninstall: (callbacks) ->
        client.del "/api/applications/#{@slug}/uninstall", callbacks

    # Send to server an update request.
    updateApp: (callbacks) ->
        client.put "/api/applications/#{@slug}/update", {}, callbacks
