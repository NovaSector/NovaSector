// THIS IS A NOVA SECTOR UI FILE
import { type ComponentProps, type ReactNode, useEffect, useState } from 'react';
import { Box, ColorBox, Dropdown, Stack } from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import type { Feature, FeatureChoicedServerData, FeatureValueProps } from './base';

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


type ExtraQuirk =
{
  color: string;
  chemical: string;
  blurb: string;
};

type DropdownOptions = ComponentProps<typeof Dropdown>['options'];

export function FeatureBloodTypeDropdownInput(props: ColorDropdownInputProps) {
  const { serverData, handleSetValue, value } = props;

  const [dropdownOptions, setDropdownOptions] = useState<DropdownOptions>([]);

  function populateOptions() {
  if (!serverData) return;

  const { choices = [] } = serverData;
  const newOptions: DropdownOptions = [];

  for (const choice of choices) {
    let displayText: ReactNode =
      serverData.display_names?.[choice] ??
      capitalizeFirst(choice);

    const quirk = serverData.extra_quirk_data?.[choice] as ExtraQuirk | undefined;
    const color = quirk?.color;

    if (quirk) {
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

    newOptions.push({
      displayText,
      value: choice,
    });
  }

  setDropdownOptions(newOptions);
}

  useEffect(() => {
    if (serverData) {
      populateOptions();
    }
  }, [serverData]);

  const displayText = serverData?.display_names?.[value] ?? String(value);
  const quirk = serverData?.extra_quirk_data?.[value] as ExtraQuirk | undefined;
  const color = quirk?.color;
  const chemical = quirk?.chemical;
  const blurb = quirk?.blurb;

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
