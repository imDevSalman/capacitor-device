import { WebPlugin } from '@capacitor/core';
export class DeviceWeb extends WebPlugin {
    constructor() {
        super({ name: 'Device', platforms: ['web'] });
    }
    async init() {
        return Error('DevicePlugin is not implemented on web.');
    }
}
//# sourceMappingURL=web.js.map