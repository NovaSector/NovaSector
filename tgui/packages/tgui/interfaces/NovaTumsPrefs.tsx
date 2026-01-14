// THIS IS A NOVA SECTOR UI FILE
import {
  Button,
  ColorBox,
  Dropdown,
  LabeledList,
  NoticeBox,
  Section,
  Slider,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

type NovaTumsPrefsData = {
  ckeyTab: string;
  title: string;
  color: string;
  use_skintone: BooleanLike;
  sizemod: number;
  sizemod_autostuffed: number;
  sizemod_audio: number;
  allow_sound_groans: BooleanLike;
  allow_sound_gurgles: BooleanLike;
  allow_sound_move_creaks: BooleanLike;
  allow_sound_move_sloshes: BooleanLike;
  calculated_size: string;
  maxsize: number;
  base_size_max: number;
  base_size_cosmetic: number;
  base_size_full: number;
  base_size_stuffed: number;
  pred_options: string[];
  pred_mode: string;
  endo_size_label: string;
  endo_size: number;
  has_belly: BooleanLike;
  prey_options: string[];
  prey_mode: string;
  has_player: BooleanLike;
  global_belly_visibility: BooleanLike;
  global_maxsize: number;
  global_sound_groans: BooleanLike;
  global_sound_gurgles: BooleanLike;
  global_sound_move_creaks: BooleanLike;
  global_sound_move_sloshes: BooleanLike;
};

export const NovaTumsPrefs = (props) => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab, changeTab] = useSharedState(data.ckeyTab, 1);

  return (
    <Window title={data.title} width={920} height={780}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Button
                  fluid
                  textAlign="center"
                  onClick={() => {
                    changeTab(1);
                    act('setTab1');
                  }}
                  disabled={data.has_player === false}
                  selected={currentTab === 1}
                >
                  Local Prefs
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  textAlign="center"
                  onClick={() => {
                    changeTab(2);
                    act('setTab2');
                  }}
                  selected={currentTab === 2}
                >
                  Character Prefs
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  textAlign="center"
                  onClick={() => {
                    changeTab(3);
                    act('setTab3');
                  }}
                  selected={currentTab === 3}
                >
                  Global Prefs
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          {currentTab === 1 && <NovaTumsPrefsCharacter />}
          {currentTab === 2 && <NovaTumsPrefsCharacter />}
          {currentTab === 3 && <NovaTumsPrefsGlobal />}
        </Stack>
      </Window.Content>
    </Window>
  );
};

const NovaTumsPrefsCharacter = (props) => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab, changeTab] = useSharedState(data.ckeyTab, 1);

  return (
    <Section fill>
      {currentTab === 1 && (
        <NoticeBox danger>
          These are in-round preferences; they will not be saved!
        </NoticeBox>
      )}
      {data.has_belly === 1 && <NovaTumsPrefsBelly />}
      {data.has_belly === 0 && (
        <NoticeBox>
          Endosoma settings - ignore if you 're not into nomming/being nommed!
        </NoticeBox>
      )}
      <LabeledList>
        <LabeledList.Item label="Prey Mode">
          <Tooltip
            content="Whether or not you want to engage in endosoma as prey on
            this character.  Query asks first, Always will always consent."
          >
            <Dropdown
              options={data.prey_options}
              selected={data.prey_mode}
              onSelected={(e) =>
                act('changePreyMode', {
                  newPredMode: e,
                  tab: currentTab,
                })
              }
              width="100%"
            />
          </Tooltip>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const NovaTumsPrefsBelly = (props) => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab, changeTab] = useSharedState(data.ckeyTab, 1);

  return (
    <>
      <NoticeBox>Belly sprite color & variant selection</NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Main Sprite Color">
          <Button
            onClick={() =>
              act('changeColor', {
                tab: currentTab,
              })
            }
            tooltip="Brings up a color picker to change the main sprite color."
          >
            <Stack align="center" fill>
              <Stack.Item>
                <ColorBox color={data.color} />
              </Stack.Item>
              <Stack.Item>Change</Stack.Item>
            </Stack>
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Use Skintone">
          <Button.Checkbox
            checked={data.use_skintone}
            fluid
            onClick={() =>
              act('changeUseSkintone', {
                tab: currentTab,
              })
            }
            tooltip="The skintone sprite palette matches up with skintone
              parts; humans, felinids, et al.  You can use a distinct color
              from your selected skintone while the palette is active!"
          >
            Use the skintone sprite palette?
          </Button.Checkbox>
        </LabeledList.Item>
      </LabeledList>
      <NoticeBox>{data.calculated_size}</NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Max Sprite Size">
          <Tooltip
            content="Max sprite size for this belly to be capable of
          reaching, agnostic of actual rendered sprites for other users.  Can't
          go above this value, even with higher max rendering prefs!"
          >
            <Slider
              step={1}
              my={1}
              value={data.maxsize}
              minValue={0}
              maxValue={16}
              unit="u"
              onChange={(e, value) =>
                act('changeMaxsize', {
                  newMaxsize: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Cosmetic Size">
          <Tooltip content="Purely cosmetic size; adds visual size.">
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_cosmetic}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u"
              onChange={(e, value) =>
                act('changeBaseCosmetic', {
                  newBaseCosmetic: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Full Size">
          <Tooltip
            content="Purely cosmetic full size; adds visual size and full
            creaks/groans."
          >
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_full}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u"
              onChange={(e, value) =>
                act('changeBaseFull', {
                  newBaseFull: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Stuffed Size">
          <Tooltip
            content="Purely cosmetic stuffed size; adds visual size,
          full creaks/groans, and stuffed gurgles/churns."
          >
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_stuffed}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u"
              onChange={(e, value) =>
                act('changeBaseStuffed', {
                  newBaseStuffed: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
      </LabeledList>
      <NoticeBox>
        Belly sound toggles - these affect what sounds your belly can make,
        distinct from what sounds you're opted into hearing (see Global Prefs)
      </NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Allow Full Groans">
          <Button.Checkbox
            checked={data.allow_sound_groans}
            fluid
            onClick={() =>
              act('changeSoundGroans', {
                tab: currentTab,
              })
            }
            tooltip="Full groans emit over time with high fullness; fullness
              comes from the base cosmetic full size, cosmetic stuffed size,
              nommed guests, and high nutrition."
          >
            Allow emitting full groans?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Stuffed Gurgles">
          <Button.Checkbox
            checked={data.allow_sound_gurgles}
            fluid
            onClick={() =>
              act('changeSoundGurgles', {
                tab: currentTab,
              })
            }
            tooltip="Stuffed gurgles emit over time with high stuffedness;
              stuffedness comes from the base cosmetic stuffed size, and high
              nutrition."
          >
            Allow emitting stuffed gurgles?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Movement Creaks">
          <Button.Checkbox
            checked={data.allow_sound_move_creaks}
            fluid
            onClick={() =>
              act('changeSoundMoveCreaks', {
                tab: currentTab,
              })
            }
            tooltip="Full creaks emit while moving on high fullness; fullness
              comes from the base cosmetic full size, cosmetic stuffed size,
              nommed guests, and high nutrition."
          >
            Allow emitting movement groans?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Movement Sloshes">
          <Button.Checkbox
            checked={data.allow_sound_move_sloshes}
            fluid
            onClick={() =>
              act('changeSoundMoveSloshes', {
                tab: currentTab,
              })
            }
            tooltip="Stuffed sloshes emit while moving on high stuffedness;
              stuffedness comes from the base cosmetic stuffed size, and high
              nutrition."
          >
            Allow emitting movement sloshes?
          </Button.Checkbox>
        </LabeledList.Item>
      </LabeledList>
      <NoticeBox>
        Endosoma settings - ignore if you 're not into nomming/being nommed!
      </NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Pred Mode">
          <Tooltip
            content="Whether or not you want to engage in endosoma as a pred
            on this character.  Query asks first, Always will always try."
          >
            <Dropdown
              options={data.pred_options}
              selected={data.pred_mode}
              onSelected={(e) =>
                act('changePredMode', {
                  newPredMode: e,
                  tab: currentTab,
                })
              }
              width="100%"
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label={data.endo_size_label}>
          <Tooltip
            content="The default size for a new bellyguest.  You can change
            their present size in-game using the belly settings verb."
          >
            <Slider
              step={0.1}
              my={1}
              value={data.endo_size}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u"
              onChange={(e, value) =>
                act('changeEndoSize', {
                  newEndoSize: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
      </LabeledList>
    </>
  );
};

const NovaTumsPrefsGlobal = (props) => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab, changeTab] = useSharedState(data.ckeyTab, 1);

  return (
    <Section fill>
      <NoticeBox>
        Belly sprite visibility - these affect what you can see.
      </NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Global Belly Visibility">
          <Button.Checkbox
            checked={data.global_belly_visibility}
            fluid
            onClick={() =>
              act('changeGlobalVisibility', {
                tab: currentTab,
              })
            }
            tooltip="The master visibility toggle disables being able to see
            belly sprites, period.  If you have a belly, it can have a sprite;
            you just won't see it!"
          >
            Allow seeing bellies at all?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Max Sprite Size">
          <Tooltip
            content="Max sprite size to render locally.  If you have a belly,
            it can go above this size; you just won't see it!"
          >
            <Slider
              step={1}
              my={1}
              value={data.global_maxsize}
              minValue={0}
              maxValue={16}
              unit="u"
              onChange={(e, value) =>
                act('changeGlobalMaxsize', {
                  newGlobalMaxsize: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
      </LabeledList>
      <NoticeBox>
        Belly sound toggles - these affect what your client actually can hear.
      </NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Allow Full Groans">
          <Button.Checkbox
            checked={data.global_sound_groans}
            fluid
            onClick={() =>
              act('changeGlobalSoundGroans', {
                tab: currentTab,
              })
            }
            tooltip="Full groans emit over time with high fullness; fullness
              comes from the base cosmetic full size, cosmetic stuffed size,
              nommed guests, and high nutrition."
          >
            Allow hearing full groans?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Stuffed Gurgles">
          <Button.Checkbox
            checked={data.global_sound_gurgles}
            fluid
            onClick={() =>
              act('changeGlobalSoundGurgles', {
                tab: currentTab,
              })
            }
            tooltip="Stuffed gurgles emit over time with high stuffedness;
              stuffedness comes from the base cosmetic stuffed size, and high
              nutrition."
          >
            Allow hearing stuffed gurgles?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Movement Creaks">
          <Button.Checkbox
            checked={data.global_sound_move_creaks}
            fluid
            onClick={() =>
              act('changeGlobalSoundMoveCreaks', {
                tab: currentTab,
              })
            }
            tooltip="Full creaks emit while moving on high fullness; fullness
              comes from the base cosmetic full size, cosmetic stuffed size,
              nommed guests, and high nutrition."
          >
            Allow hearing movement groans?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Allow Movement Sloshes">
          <Button.Checkbox
            checked={data.global_sound_move_sloshes}
            fluid
            onClick={() =>
              act('changeGlobalSoundMoveSloshes', {
                tab: currentTab,
              })
            }
            tooltip="Stuffed sloshes emit while moving on high stuffedness;
              stuffedness comes from the base cosmetic stuffed size, and high
              nutrition."
          >
            Allow hearing movement sloshes?
          </Button.Checkbox>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
