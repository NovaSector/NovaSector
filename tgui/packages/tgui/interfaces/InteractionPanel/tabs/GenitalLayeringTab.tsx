// THIS IS A NOVA SECTOR UI FILE
import {
  Button,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
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

// Icon + tooltip blurb for every option label the server can send.
// Unknown labels fall back to a plain text button, so adding an option
// server-side degrades gracefully instead of rendering a blank icon.
const OPTION_META: Record<string, { icon: string; blurb: string }> = {
  'Never show': {
    icon: 'eye-slash',
    blurb: 'Never rendered, no matter what.',
  },
  'Hidden by clothes': {
    icon: 'shirt',
    blurb: 'Shown when nothing covers it, hidden by clothing.',
  },
  Custom: {
    icon: 'sliders',
    blurb: 'Manual control - unlocks the layering options.',
  },
  'Below underwear': {
    icon: 'angles-down',
    blurb: 'Always rendered, tucked behind your underwear.',
  },
  Normal: {
    icon: 'grip-lines',
    blurb: 'Default layer - behaves like Hidden by clothes.',
  },
  'Above underwear': {
    icon: 'angles-up',
    blurb: 'Always rendered, over underwear but under outerwear.',
  },
  'Above all clothing': {
    icon: 'circle-arrow-up',
    blurb: 'Rendered on top of everything you wear.',
  },
  'Not aroused': {
    icon: 'temperature-empty',
    blurb: 'Not aroused.',
  },
  'Partly aroused': {
    icon: 'temperature-half',
    blurb: 'Partly aroused.',
  },
  'Very aroused': {
    icon: 'temperature-full',
    blurb: 'Very aroused.',
  },
};

export const GenitalLayeringTab = () => {
  const { act, data } = useBackend<GenitalConfig>();
  const {
    genital_config = [],
    genital_visibility_options = [],
    genital_layering_options = [],
    genital_arousal_options = [],
  } = data;

  const renderOption = (
    option: string,
    selectedOption: string | null,
    action: string,
    ref: string,
    disabled?: boolean,
  ) => {
    const meta = OPTION_META[option];
    const tooltip = disabled
      ? `${option} - select Custom visibility to unlock`
      : meta
        ? `${option} - ${meta.blurb}`
        : option;
    return (
      <Button
        key={option}
        icon={meta?.icon}
        selected={option === selectedOption}
        disabled={disabled}
        tooltip={tooltip}
        onClick={() => act(action, { ref: ref, option: option })}
      >
        {meta ? undefined : option}
      </Button>
    );
  };

  return (
    <Stack fill vertical>
      <NoticeBox>
        {genital_config.length > 0
          ? 'Configure how your genitals render - hover a button for details'
          : 'Nothing to configure'}
      </NoticeBox>
      <Stack.Item grow>
        <Section scrollable>
          <Table>
            <Table.Row header>
              <Table.Cell />
              <Table.Cell collapsing textAlign="center" color="label" pl={2}>
                Visibility
              </Table.Cell>
              <Table.Cell collapsing textAlign="center" color="label" pl={2}>
                Layering
              </Table.Cell>
              <Table.Cell collapsing textAlign="center" color="label" pl={2}>
                Arousal
              </Table.Cell>
            </Table.Row>
            {genital_config.map((genital) => (
              <Table.Row key={genital.ref} className="candystripe">
                <Table.Cell bold verticalAlign="middle">
                  {genital.name}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center" pl={2}>
                  {genital_visibility_options.map((option) =>
                    renderOption(
                      option,
                      genital.visibility,
                      'set_genital_visibility',
                      genital.ref,
                    ),
                  )}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center" pl={2}>
                  {genital_layering_options.map((option) =>
                    renderOption(
                      option,
                      genital.layering,
                      'set_genital_layering',
                      genital.ref,
                      !genital.custom,
                    ),
                  )}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center" pl={2}>
                  {!!genital.can_arouse &&
                    genital_arousal_options.map((option) =>
                      renderOption(
                        option,
                        genital.arousal,
                        'set_genital_arousal',
                        genital.ref,
                      ),
                    )}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
