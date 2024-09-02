var capacitorDevice = (function (exports, core) {
    'use strict';

    const Device = core.registerPlugin('Device', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.DeviceWeb()),
    });

    class DeviceWeb extends core.WebPlugin {
        constructor() {
            super({ name: 'Device', platforms: ['web'] });
        }
        async initialize() {
            return Error('DevicePlugin is not implemented on web.');
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        DeviceWeb: DeviceWeb
    });

    exports.Device = Device;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
