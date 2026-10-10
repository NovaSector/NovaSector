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
  hide_with_uniform: BooleanLike;
  color_with_uniform: BooleanLike;
  layer_mode: string;
  sizemod: number;
  sizemod_nutrition: number;
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
  layer_options: string[];
  global_belly_visibility: BooleanLike;
  global_maxsize: number;
  global_sound_groans: BooleanLike;
  global_sound_gurgles: BooleanLike;
  global_sound_move_creaks: BooleanLike;
  global_sound_move_sloshes: BooleanLike;
};

const SOUND_TOOLTIPS = {
  groans:
    'Full groans emit over time with high fullness; fullness comes from the ' +
    'base cosmetic full size, cosmetic stuffed size, nommed guests, and high ' +
    'nutrition.',
  gurgles:
    'Stuffed gurgles emit over time with high stuffedness; stuffedness comes ' +
    'from the base cosmetic stuffed size, and high nutrition.',
  creaks:
    'Full creaks emit while moving on high fullness; fullness comes from the ' +
    'base cosmetic full size, cosmetic stuffed size, nommed guests, and high ' +
    'nutrition.',
  sloshes:
    'Stuffed sloshes emit while moving on high stuffedness; stuffedness comes ' +
    'from the base cosmetic stuffed size, and high nutrition.',
};

type SoundToggleProps = {
  label: string;
  checked: BooleanLike;
  action: string;
  tooltip: string;
  text: string;
  tab: number;
};

const SoundToggle = (props: SoundToggleProps) => {
  const { act } = useBackend<NovaTumsPrefsData>();
  return (
    <LabeledList.Item label={props.label}>
      <Button.Checkbox
        checked={props.checked}
        fluid
        onClick={() => act(props.action, { tab: props.tab })}
        tooltip={props.tooltip}
      >
        {props.text}
      </Button.Checkbox>
    </LabeledList.Item>
  );
};

export const NovaTumsPrefs = () => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [storedTab, changeTab] = useSharedState(data.ckeyTab, 1);

  // Derive the tab actually shown. If there's no player, tab 1 is meaningless,
  // so it resolves to 2 without touching state or firing effects.
  const currentTab = !data.has_player && storedTab === 1 ? 2 : storedTab;

  const selectTab = (tab: number) => {
    changeTab(tab);
    act(`setTab${tab}`);
  };

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
                  onClick={() => selectTab(1)}
                  disabled={!data.has_player}
                  selected={currentTab === 1}
                >
                  Local Prefs
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  textAlign="center"
                  onClick={() => selectTab(2)}
                  selected={currentTab === 2}
                >
                  Character Prefs
                </Button>
              </Stack.Item>
              <Stack.Item grow>
                <Button
                  fluid
                  textAlign="center"
                  onClick={() => selectTab(3)}
                  selected={currentTab === 3}
                >
                  Global Prefs
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          {(currentTab === 1 || currentTab === 2) && <NovaTumsPrefsCharacter />}
          {currentTab === 3 && <NovaTumsPrefsGlobal />}
        </Stack>
      </Window.Content>
    </Window>
  );
};

const NovaTumsPrefsCharacter = () => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab] = useSharedState(data.ckeyTab, 1);

  return (
    <Section fill>
      {currentTab === 1 && (
        <NoticeBox danger>
          These are in-round preferences; they will not be saved!
        </NoticeBox>
      )}
      {!!data.has_belly && <NovaTumsPrefsBelly />}
      {!data.has_belly && (
        <NoticeBox>
          Endosoma settings - ignore if you're not into nomming/being nommed!
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
                  newPreyMode: e,
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

const NovaTumsPrefsBelly = () => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab] = useSharedState(data.ckeyTab, 1);

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
        <LabeledList.Item label="Hide with Uniform">
          <Button.Checkbox
            checked={data.hide_with_uniform}
            fluid
            onClick={() =>
              act('changeUniformHide', {
                tab: currentTab,
              })
            }
            tooltip="Hides your belly if you're wearing a uniform or suit that
            would hide your torso.  Not always reliable due to inconsistent
            bitflag application across undersuits!"
          >
            Hide belly with uniform?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Color with Uniform">
          <Button.Checkbox
            checked={data.color_with_uniform}
            fluid
            onClick={() =>
              act('changeUniformColor', {
                tab: currentTab,
              })
            }
            tooltip="Tries to color your belly to match your equipped
            undersuit.  This won't always be reliable- not all uniforms provide
            colors for fallback generation!"
          >
            Color belly with uniform?
          </Button.Checkbox>
        </LabeledList.Item>
        <LabeledList.Item label="Layer Mode">
          <Tooltip content="Adjusts belly layering order.">
            <Dropdown
              options={data.layer_options}
              selected={data.layer_mode}
              onSelected={(e) =>
                act('changeLayerMode', {
                  newLayerMode: e,
                  tab: currentTab,
                })
              }
              width="100%"
            />
          </Tooltip>
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
        <LabeledList.Item label="Base Size">
          <Tooltip
            content="Purely cosmetic belly size; adds visual size.
          Final size = base size + full size + stuffed size.  Note that the
          final size calculation is volumetric- it takes exponentially more
          to increase the sprite size the bigger you go!"
          >
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_cosmetic}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u^3"
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
            content="Purely cosmetic fullness size; adds additional base size
            and full creaks/groans, if you have them enabled.
            Final contribution to fullness sounds = full size + stuffed size."
          >
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_full}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u^3"
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
            content="Purely cosmetic stuffed size; adds additional fullness
          size, and stuffed gurgles/churns, if you have them enabled."
          >
            <Slider
              step={0.1}
              my={1}
              value={data.base_size_stuffed}
              minValue={0}
              maxValue={data.base_size_max}
              unit="u^3"
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
      <NoticeBox>Size Modifiers</NoticeBox>
      <LabeledList>
        <LabeledList.Item label="Visual Size Modifier">
          <Tooltip
            content="This is a multiplier applied to all size sources when
            calculating the sprite size.  Good if you're playing a shorter
            critter who should be more heavily impacted- or vice-versa.  Stacks
            multiplicatively with the nutrition size mod."
          >
            <Slider
              step={0.01}
              my={1}
              value={data.sizemod}
              minValue={0}
              maxValue={10}
              unit="x"
              onChange={(e, value) =>
                act('changeSizemod', {
                  newSizemod: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Sound Size Modifier">
          <Tooltip
            content="This is a multiplier applied to all size sources when
            calculating how intense belly sounds should be.  Applied separate
            from the visual size modifier, for fine tuning.  Good if you're
            playing a critter with a particularly cranky *or* calm belly."
          >
            <Slider
              step={0.01}
              my={1}
              value={data.sizemod_audio}
              minValue={0}
              maxValue={10}
              unit="x"
              onChange={(e, value) =>
                act('changeSizemodAudio', {
                  newSizemodAudio: value,
                  tab: currentTab,
                })
              }
            />
          </Tooltip>
        </LabeledList.Item>
        <LabeledList.Item label="Nutrition Size Modifier">
          <Tooltip
            content="Contributions to the Stuffed Size from your Nutrition and
            stomach contents are multiplied by this.  Good if you'd rather have
            manual control for a scene, or don't want to suddenly look stuffed
            from taking the average veteran chemist's heal-all pill."
          >
            <Slider
              step={0.01}
              my={1}
              value={data.sizemod_nutrition}
              minValue={0}
              maxValue={10}
              unit="x"
              onChange={(e, value) =>
                act('changeSizemodNutrition', {
                  newSizemodNutrition: value,
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
        <SoundToggle
          label="Allow Full Groans"
          checked={data.allow_sound_groans}
          action="changeSoundGroans"
          tooltip={SOUND_TOOLTIPS.groans}
          text="Allow emitting full groans?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Stuffed Gurgles"
          checked={data.allow_sound_gurgles}
          action="changeSoundGurgles"
          tooltip={SOUND_TOOLTIPS.gurgles}
          text="Allow emitting stuffed gurgles?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Movement Creaks"
          checked={data.allow_sound_move_creaks}
          action="changeSoundMoveCreaks"
          tooltip={SOUND_TOOLTIPS.creaks}
          text="Allow emitting movement groans?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Movement Sloshes"
          checked={data.allow_sound_move_sloshes}
          action="changeSoundMoveSloshes"
          tooltip={SOUND_TOOLTIPS.sloshes}
          text="Allow emitting movement sloshes?"
          tab={currentTab}
        />
      </LabeledList>
      <NoticeBox>
        Endosoma settings - ignore if you're not into nomming/being nommed!
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
              unit="u^3"
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

const NovaTumsPrefsGlobal = () => {
  const { act, data } = useBackend<NovaTumsPrefsData>();
  const [currentTab] = useSharedState(data.ckeyTab, 1);

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
        <SoundToggle
          label="Allow Full Groans"
          checked={data.global_sound_groans}
          action="changeGlobalSoundGroans"
          tooltip={SOUND_TOOLTIPS.groans}
          text="Allow hearing full groans?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Stuffed Gurgles"
          checked={data.global_sound_gurgles}
          action="changeGlobalSoundGurgles"
          tooltip={SOUND_TOOLTIPS.gurgles}
          text="Allow hearing stuffed gurgles?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Movement Creaks"
          checked={data.global_sound_move_creaks}
          action="changeGlobalSoundMoveCreaks"
          tooltip={SOUND_TOOLTIPS.creaks}
          text="Allow hearing movement groans?"
          tab={currentTab}
        />
        <SoundToggle
          label="Allow Movement Sloshes"
          checked={data.global_sound_move_sloshes}
          action="changeGlobalSoundMoveSloshes"
          tooltip={SOUND_TOOLTIPS.sloshes}
          text="Allow hearing movement sloshes?"
          tab={currentTab}
        />
      </LabeledList>
    </Section>
  );
};
