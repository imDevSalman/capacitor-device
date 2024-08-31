import { WebPlugin } from '@capacitor/core';
import type { DevicePlugin } from './definitions';
export declare class DeviceWeb extends WebPlugin implements DevicePlugin {
    constructor();
    init(): Promise<any>;
}
