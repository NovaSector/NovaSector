// THIS IS A NOVA SECTOR UI FILE
import {
  Box,
  Button,
  Dimmer,
  Divider,
  Icon,
  Section,
  Stack,
  StyleableSection,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  food_types: Record<string, number>;
  obscure_food_types: string;
  selection: Record<string, number>;
  enabled: boolean;
  invalid: string;
  race_disabled: boolean;
  limits: Record<string, number>;
  counts: Record<string, number>;
};

const FOOD_TOXIC = 1;
const FOOD_DISLIKED = 2;
const FOOD_NEUTRAL = 3;
const FOOD_LIKED = 4;

export const FoodPreferences = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    counts,
    limits,
    obscure_food_types,
    invalid,
    selection,
    enabled,
    race_disabled,
    food_types,
  } = data;

  return (
    <Window width={1300} height={600}>
      <Window.Content scrollable>
        {
          <StyleableSection
            style={{
              'margin-bottom': '1em',
              'break-inside': 'avoid-column',
            }}
            titleStyle={{
              'justify-content': 'center',
            }}
            title={
              <Box>
                <Tooltip
                  position="bottom"
                  content={
                    'You HAVE to pick at lease ONE TOXIC food and TWO Disliked foods. You Can have a maximum of THREE LIKED foods.'
                  }
                >
                  <Box inline>
                    <Button icon="circle-question" mr="0.5em" />
                    {invalid ? (
                      <Box as="span" color="#bd2020">
                        Prefrences are Invalid!{' '}
                        {invalid.charAt(0).toUpperCase() + invalid.slice(1)} |{' '}
                        {counts.disliked < 2
                          ? counts.disliked + '/2 Disliked'
                          : counts.toxic + '/1 Toxic'}
                      </Box>
                    ) : (
                      <Box as="span" color="green">
                        Preferences are Valid! | <b>{counts.liked}</b>/3 Liked
                      </Box>
                    )}
                  </Box>
                </Tooltip>

                <Button
                  style={{ position: 'absolute', right: '20em' }}
                  color={'red'}
                  onClick={() => act('reset')}
                  tooltip="Reset to the default values!"
                >
                  Reset
                </Button>

                <Button
                  style={{ position: 'absolute', right: '0.5em' }}
                  icon={enabled ? 'check-square-o' : 'square-o'}
                  color={enabled ? 'green' : 'red'}
                  onClick={() => act('toggle')}
                  disabled={race_disabled}
                  tooltip={
                    <>
                      Toggles if these food preferences will be applied to your
                      character on spawn.
                      <Divider />
                      Remember, these are mostly suggestions, and you are
                      encouraged to roleplay liking meals that your character
                      likes, even if you don&apos;t have it&apos;s food type
                      liked here!
                    </>
                  }
                >
                  Use Custom Food Preferences
                </Button>
              </Box>
            }
          >
            {(race_disabled && (
              <ErrorOverlay>
                You&apos;re using a race which isn&apos;t affected by food
                preferences!
              </ErrorOverlay>
            )) ||
              (!enabled && (
                <ErrorOverlay>Your food preferences are disabled!</ErrorOverlay>
              ))}
            <Box style={{ columns: '30em' }}>
              {Object.entries(food_types).map((element) => {
                const { 0: foodName, 1: foodPointValues } = element;
                return (
                  <Box key={foodName}>
                    <Section
                      title={
                        <>
                          {foodName}
                          {obscure_food_types.includes(foodName) && (
                            <Tooltip content="This food doesn't count towards your maximum likes, and is free!">
                              <Box
                                as="span"
                                fontSize={0.75}
                                verticalAlign={'top'}
                              >
                                &nbsp;
                                <Icon name="star" style={{ color: 'orange' }} />
                              </Box>
                            </Tooltip>
                          )}
                        </>
                      }
                    >
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_TOXIC}
                        selected={
                          selection[foodName] === FOOD_TOXIC ||
                          (!selection[foodName] &&
                            foodPointValues === FOOD_TOXIC)
                        }
                        content={<>Toxic</>}
                        color="olive"
                        tooltip="Your character will almost immediately throw up on eating anything toxic."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_DISLIKED}
                        disabled={
                          !obscure_food_types.includes(foodName) &&
                          counts.toxic < limits.min_toxic
                        }
                        selected={
                          selection[foodName] === FOOD_DISLIKED ||
                          (!selection[foodName] &&
                            foodPointValues === FOOD_DISLIKED)
                        }
                        content={<>Disliked</>}
                        color="red"
                        tooltip="Your character will become grossed out, before eventually throwing up after a decent intake of disliked food."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_NEUTRAL}
                        disabled={
                          (!obscure_food_types.includes(foodName) &&
                            counts.toxic < limits.min_toxic) ||
                          (!obscure_food_types.includes(foodName) &&
                            counts.disliked < limits.min_disliked)
                        }
                        selected={
                          selection[foodName] === FOOD_NEUTRAL ||
                          (!selection[foodName] &&
                            foodPointValues === FOOD_NEUTRAL)
                        }
                        content={<>Neutral</>}
                        color="yellow"
                        tooltip="Your character has very little to say about something that's neutral."
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_LIKED}
                        disabled={
                          (!obscure_food_types.includes(foodName) &&
                            counts.liked >= limits.max_liked) ||
                          (!obscure_food_types.includes(foodName) &&
                            counts.disliked < limits.min_disliked) ||
                          (!obscure_food_types.includes(foodName) &&
                            counts.toxic < limits.min_toxic)
                        }
                        selected={
                          selection[foodName] === FOOD_LIKED ||
                          (!selection[foodName] &&
                            foodPointValues === FOOD_LIKED)
                        }
                        content={<>Liked</>}
                        color="green"
                        tooltip={
                          !obscure_food_types.includes(foodName) &&
                          counts.liked >= 3
                            ? 'You currently have too many liked foods, you cannot have more than three foods that are not obscure!'
                            : "Your character will enjoy anything that's liked."
                        }
                      />
                    </Section>
                  </Box>
                );
              })}
            </Box>
          </StyleableSection>
        }
      </Window.Content>
    </Window>
  );
};

const FoodButton = (props) => {
  const { act } = useBackend();
  const { foodName, foodPreference, color, selected, ...rest } = props;
  return (
    <Button
      icon={selected ? 'check-square-o' : 'square-o'}
      color={selected ? color : 0x3e6189}
      onClick={() =>
        act('change_food', {
          food_name: foodName,
          food_preference: foodPreference,
        })
      }
      {...rest}
    />
  );
};

const ErrorOverlay = (props) => {
  return (
    <Dimmer>
      <Stack vertical mt="5.2em">
        <Stack.Item color="#bd2020" textAlign="center">
          {props.children}
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};
