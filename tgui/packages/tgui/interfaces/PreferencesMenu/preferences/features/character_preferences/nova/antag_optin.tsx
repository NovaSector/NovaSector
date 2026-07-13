// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const antag_opt_in_status_pref: FeatureChoiced = {
  name: 'Be Antagonist Target',
  description:
    'This modifies how the Dynamic targeting system selects you as a target. \
    No will prevent you from being a target for antagonist objectives. \
    Inconvenience will make you a target for antagonist objectives that are usually not lethal. \
    Kill will make you a target for all lethal antagonist objectives. \
    Round Remove will make you a target for round removal. \
    Enabling any non-ghost antagonists (Revenant, Contractor, etc.) \
    will force your opt-in to be, at minimum, \
    "Inconvenience".',
  component: FeatureDropdownInput,
};
