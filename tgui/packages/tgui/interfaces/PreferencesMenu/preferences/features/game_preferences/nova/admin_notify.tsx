// For use with the Admin Notify Verb, if admins dont want to hear a ping for it
import { CheckboxInput, type FeatureToggle } from '../../base';

export const admin_notify_alert: FeatureToggle = {
  name: 'Admin Notify sound alert',
  category: 'ADMIN',
  description:
    'When enabled, plays a sound when a player uses the "Notify Admins" verb to request observation.',
  component: CheckboxInput,
};
