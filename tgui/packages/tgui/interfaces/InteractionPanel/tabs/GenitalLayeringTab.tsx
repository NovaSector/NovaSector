// THIS IS A NOVA SECTOR UI FILE
import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../../backend';

type GenitalConfigEntry = {
  name: string;
  ref: string;
  visibility: string | null;
  layering: string | null;
  custom: BooleanLike;
  arousal: string | null;
  can_arouse: BooleanLike;
};

type GenitalConfig = {
  genital_config: GenitalConfigEntry[];
  genital_visibility_options: string[];
  genital_layering_options: string[];
  genital_arousal_options: string[];
};

export const GenitalLayeringTab = () => {
  const { act, data } = useBackend<GenitalConfig>();
  const {
    genital_config = [],
    genital_visibility_options = [],
    genital_layering_options = [],
    genital_arousal_options = [],
  } = data;

  return (
    <Stack fill vertical>
      <NoticeBox>
        {genital_config.length > 0
          ? 'Configure how your genitals show through clothing'
          : 'Nothing to configure'}
      </NoticeBox>
      <Stack.Item grow>
        <Section scrollable>
          {genital_config.map((genital) => (
            <Section key={genital.ref} title={genital.name}>
              <Stack>
                <Stack.Item grow basis={0}>
                  <Section title="Visibility">
                    {genital_visibility_options.map((option) => (
                      <Button
                        key={option}
                        fluid
                        selected={option === genital.visibility}
                        onClick={() =>
                          act('set_genital_visibility', {
                            ref: genital.ref,
                            option: option,
                          })
                        }
                      >
                        {option}
                      </Button>
                    ))}
                  </Section>
                </Stack.Item>
                {!!genital.custom && (
                  <Stack.Item grow basis={0}>
                    <Section title="Layering">
                      {genital_layering_options.map((option) => (
                        <Button
                          key={option}
                          fluid
                          selected={option === genital.layering}
                          onClick={() =>
                            act('set_genital_layering', {
                              ref: genital.ref,
                              option: option,
                            })
                          }
                        >
                          {option}
                        </Button>
                      ))}
                    </Section>
                  </Stack.Item>
                )}
                {!!genital.can_arouse && (
                  <Stack.Item grow basis={0}>
                    <Section title="Arousal">
                      {genital_arousal_options.map((option) => (
                        <Button
                          key={option}
                          fluid
                          selected={option === genital.arousal}
                          onClick={() =>
                            act('set_genital_arousal', {
                              ref: genital.ref,
                              option: option,
                            })
                          }
                        >
                          {option}
                        </Button>
                      ))}
                    </Section>
                  </Stack.Item>
                )}
              </Stack>
            </Section>
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
