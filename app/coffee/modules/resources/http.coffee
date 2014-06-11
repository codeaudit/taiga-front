# Copyright (C) 2014 Andrey Antukh <niwi@niwi.be>
# Copyright (C) 2014 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014 David Barragán Merino <bameda@dbarragan.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

taiga = @.taiga

class HttpService extends taiga.TaigaService
    @.$inject = ["$http", "$q", "$tgStorage"]

    headers: ->
        token = @storage.get('token')
        if token
            return {"Authorization":"Bearer #{token}"}
        return {}

    constructor: (@http, @q, @storage) ->
        super()

    request: (options) ->
        options.headers = _.merge({}, options.headers or {}, @.headers())
        if _.isPlainObject(options.data)
            options.data = JSON.stringify(options.data)

        return @http(options)

    get: (url, params) ->
        return @.request({
            method: "GET",
            url: url,
            params: params
        })

    post: (url, data, params) ->
        options = {method: "POST", url: url}
        options.data = data if data
        options.params = params if params
        return @.request(options)

    put: (url, data, params) ->
        options = {method: "PUT", url: url}
        options.data = data if data
        options.params = params if params
        return @.request(options)

    patch: (url, data, params) ->
        options = {method: "PATCH", url: url}
        options.data = data if data
        options.params = params if params
        return @.request(options)

    delete: (url, data, params) ->
        options = {method: "DELETE", url: url}
        options.data = data if data
        options.params = params if params
        return @.request(options)


module = angular.module("taigaResources")
module.service("$tgHttp", HttpService)