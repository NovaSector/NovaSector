import { useBackend } from 'tgui/backend';
import {
  Button,
} from 'tgui-core/components';

import {
  type PreferencesMenuData,
} from '../../types';

import type { FeatureValueProps } from './base';

export function FeatureBellyButton(props: FeatureValueProps<number>) {
  const { act } = useBackend<PreferencesMenuData>();
  const { featureId} = props;

  return (
    <Button
      onClick={() => {
        act('open_belly_prefs', {
          preference: featureId,
        });
      }}
    >
      Open
    </Button>
  );
}
