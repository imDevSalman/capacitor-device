import { WebPlugin } from '@capacitor/core';

import type { DevicePlugin } from './definitions';

export class DeviceWeb extends WebPlugin implements DevicePlugin {
  constructor() {
    super({ name: 'Device', platforms: ['web'] });
  }
  async initialize(): Promise<any> {
    return Error('DevicePlugin is not implemented on web.');
  }
}
