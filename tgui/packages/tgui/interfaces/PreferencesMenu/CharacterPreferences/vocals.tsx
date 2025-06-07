import { filter } from 'common/collections';
import { useState } from 'react';
import {
  Box,
  Button,
  FitText,
  Icon,
  Input,
  LabeledList,
  Modal,
  Section,
  Stack,
  TrackOutsideClicks,
} from 'tgui-core/components';
import { getRandomization, PreferenceList } from './MainPage';
import { createLogger } from '../../../../tgui-dev-server/logging';

type VocalsProps = {
  handleClose: () => void;
  handleUpdateName: (
    nameType: string,
    value: string | number | boolean,
  ) => void;
  vocals: Record<string, string | number | boolean>;
};

type VocalFeature = {
  id: string;
  label: string;
  description?: string;
  type: 'string' | 'number' | 'boolean';
};

const vocalFeatures: VocalFeature[] = [
  { id: 'voice_type', label: 'Voice Type', type: 'string' },
  { id: 'blooper_speech', label: 'Blooper Speech', type: 'string' },
  { id: 'blooper_speech_speed', label: 'Blooper Speed', type: 'number' },
  { id: 'blooper_speech_pitch', label: 'Blooper Pitch', type: 'number' },
  { id: 'fallback_to_blooper', label: 'Fallback to Blooper', type: 'boolean' },
];

type FeatureValueInputProps = {
  feature: VocalFeature;
  value: string;
  onChange: (value: string | number | boolean) => void;
};

function getCorrespondingPreferences(
  customization_options: string[],
  relevant_preferences: Record<string, string>,
) {
  return Object.fromEntries(
    filter(Object.entries(relevant_preferences), ([key, value]) =>
      customization_options.includes(key),
    ),
  );
}

function FeatureValueInput({
  feature,
  value,
  onChange,
}: FeatureValueInputProps) {
  switch (feature.type) {
    case 'string':
      const logger = createLogger('fuck');
      logger.log('value:');
      logger.log('feature:');
      return (
        <Stack.Item>
          <PreferenceList
            preferences={getCorrespondingPreferences([value], feature)}
            randomizations={getRandomization(
              getCorrespondingPreferences([value], feature),
              undefined,
              false,
            )}
            maxHeight="160px" // NOVA EDIT CHANGE - ORIGINAL: 100px
          />
        </Stack.Item>
      );

    case 'number':
      return (
        <Input
          type="number"
          value={String(value)}
          onChange={(e, val) => {
            const num = Number(val);
            if (!isNaN(num)) onChange(num);
          }}
          onEnter={(e, val) => {
            const num = Number(val);
            if (!isNaN(num)) onChange(num);
          }}
          autoSelect
        />
      );

    case 'boolean':
      return (
        <Button onClick={() => onChange(!value)} width="100%">
          {value ? 'Yes' : 'No'}
        </Button>
      );

    default:
      return <Box>Unsupported type</Box>;
  }
}

export function VocalsInput(props: VocalsProps) {
  const { vocals, handleUpdateName, handleClose } = props;

  return (
    <Modal>
      <TrackOutsideClicks onOutsideClick={handleClose}>
        <Section
          title="Voice Settings"
          buttons={
            <Button color="red" onClick={handleClose}>
              Close
            </Button>
          }
        >
          <LabeledList>
            {vocalFeatures.map((feature) => {
              const value = vocals[feature.id];
              if (value === undefined) return null;

              return (
                <LabeledList.Item
                  key={feature.id}
                  label={<Box mt={0.5}>{feature.label}</Box>}
                  tooltip={feature.description}
                  verticalAlign="top"
                >
                  <FeatureValueInput
                    feature={feature}
                    value={value}
                    onChange={(val) => handleUpdateName(feature.id, val)}
                  />
                </LabeledList.Item>
              );
            })}
          </LabeledList>
        </Section>
      </TrackOutsideClicks>
    </Modal>
  );
}

type VoiceInputProps = {
  openVocalsInput: () => void;
  vocals: Record<string, string | number | boolean>;
};

export function VoiceInput(props: VoiceInputProps) {
  return (
    <Button
      onClick={(event) => {
        props.openVocalsInput();
        event.cancelBubble = true;
        event.stopPropagation();
      }}
      textAlign="center"
      width="100%"
      height="28px"
    >
      <Stack align="center" fill>
        <Stack.Item>
          <Icon
            style={{
              color: 'rgba(255, 255, 255, 0.5)',
              fontSize: '17px',
            }}
            name="fa-microphone" // changed from fa-comment to microphone for speaking
          />
        </Stack.Item>

        <Stack.Item grow position="relative" mt={0.6}>
          <FitText maxFontSize={16} maxWidth={130}>
            Voice Settings
          </FitText>
        </Stack.Item>
      </Stack>
    </Button>
  );
}
