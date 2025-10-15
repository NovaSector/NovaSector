// THIS IS A NOVA SECTOR UI FILE
import type {
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const health_analyzer_themes: FeatureChoiced = {
  name: 'Health Analyzer Theme',
  category: 'UI',
  description: 'Choose the theme for the health analyzer UI.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
