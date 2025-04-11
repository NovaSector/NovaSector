// THIS IS A NOVA SECTOR UI FILE
import { ComponentProps, ReactNode, useEffect, useState } from 'react';
import { Box, ColorBox, Dropdown, Stack } from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import { Feature, FeatureChoicedServerData, FeatureValueProps } from './base';

type ColorDropdownInputProps = FeatureValueProps<
  string,
  string,
  FeatureChoicedServerData
>;

export type FeatureWithExtraQuirkData<T> = Feature<
  string,
  T,
  FeatureChoicedServerData
>;

type DropdownOptions = ComponentProps<typeof Dropdown>['options'];

export function FeatureBloodTypeDropdownInput(props: ColorDropdownInputProps) {
  const { serverData, handleSetValue, value } = props;

  const [dropdownOptions, setDropdownOptions] = useState<DropdownOptions>([]);

  function populateOptions() {
    if (!serverData) return;
    const { choices = [] } = serverData;

    let newOptions: DropdownOptions = [];

    for (const choice of choices) {
      let displayText: ReactNode = serverData.display_names?.[choice]
        ? serverData.display_names?.[choice]
        : capitalizeFirst(choice);
      let color = serverData.extra_quirk_data?.[choice]['color'];

      if (serverData.extra_quirk_data?.[choice]) {
        displayText = (
          <Stack>
            <Stack.Item>
              <ColorBox
                style={{
                  border: '2px solid white',
                  boxSizing: 'content-box',
                }}
                color={color}
              />
            </Stack.Item>
            <Stack.Item grow>{displayText}</Stack.Item>
          </Stack>
        );
      }
      setDropdownOptions(newOptions);
      newOptions.push({
        displayText,
        value: choice,
      });
    }
  }

  useEffect(() => {
    if (serverData) {
      populateOptions();
    }
  }, [serverData]);

  const displayText = serverData?.display_names?.[value] || String(value);
  const color = serverData?.extra_quirk_data?.[value]['color'];
  const chemical = serverData?.extra_quirk_data?.[value]['chemical'];
  const blurb = serverData?.extra_quirk_data?.[value]['blurb'];

  return (
    <Stack vertical>
      <Stack.Item>
        <Dropdown
          buttons
          displayText={
            <Stack>
              <Stack.Item>
                <ColorBox
                  style={{
                    border: '2px solid white',
                    boxSizing: 'content-box',
                  }}
                  color={color}
                />
              </Stack.Item>
              <Stack.Item grow>{displayText}</Stack.Item>
            </Stack>
          }
          onSelected={handleSetValue}
          options={dropdownOptions}
          selected={value}
          width="100%"
        />
      </Stack.Item>

      <Stack vertical>
        <Stack.Item>
          <Box mt={1} color="white">
            <b>Blood Chemical:</b> {chemical}
          </Box>
        </Stack.Item>
        {!!blurb && (
          <Stack.Item>
            <Box mt={1} color="white">
              {blurb}
            </Box>
          </Stack.Item>
        )}
      </Stack>
    </Stack>
  );
}
