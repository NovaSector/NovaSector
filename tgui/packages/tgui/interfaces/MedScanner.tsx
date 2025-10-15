import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  Icon,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import '../styles/interfaces/MedScanner.scss';

type MedScannerData = {
  patient: string;
  species: string;
  dead: boolean;
  health: number;
  max_health: number;
  crit_threshold: number;
  dead_threshold: number;
  total_brute: number;
  total_burn: number;
  toxin: number;
  oxy: number;
  stamina: number;
  revivable_boolean: boolean;
  revivable_string: number;
  has_chemicals: boolean;
  chemicals_lists: object;
  limb_data_lists: object;
  limbs_damaged: object;
  damaged_organs: any[];
  ssd: string;
  blood_type: string;
  blood_amount: number;
  body_temperature: string;
  advice: any;
  accessible_theme: string;
  available_themes: string[];
  majquirks: any;
  minquirks: any;
  custom_species: string;
  wounds: any[];
  brain_traumas: any;
  viruses: any[];
  has_alien_embryo: boolean;
  embryo_stage: number;
  medical_alerts: any[];
};

export const MedScanner = () => {
  const { data } = useBackend<MedScannerData>();
  const {
    species,
    has_chemicals,
    limbs_damaged,
    damaged_organs,
    blood_amount,
    advice,
    accessible_theme,
    wounds,
    viruses,
    has_alien_embryo,
    medical_alerts,
  } = data;
  return (
    <Window width={515} height={615} theme={accessible_theme}>
      <Window.Content scrollable>
        <PatientBasics />
        {has_alien_embryo ? <AlienEmbryo /> : null}
        {medical_alerts?.length ? <MedicalAlerts /> : null}
        {has_chemicals ? <PatientChemicals /> : null}
        {limbs_damaged ? <PatientLimbs /> : null}
        {damaged_organs.length ? <PatientOrgans /> : null}
        {blood_amount ? <PatientBlood /> : null}
        {advice ? <PatientAdvice /> : null}
        {wounds.length ? <Wounds /> : null}
        {viruses.length ? <Viruses /> : null}
      </Window.Content>
    </Window>
  );
};

const PatientBasics = () => {
  const { act, data } = useBackend<MedScannerData>();
  const {
    patient,
    species,
    dead,

    health,
    max_health,
    crit_threshold,
    dead_threshold,

    total_brute,
    total_burn,
    toxin,
    oxy,
    stamina,

    revivable_boolean,
    revivable_string,

    ssd,

    accessible_theme,
    available_themes,

    majquirks,
    minquirks,
    custom_species,
    brain_traumas,
  } = data;
  return (
    <>
      <Section
        title={
          (species === 'Synthetic Humanoid' ? 'Unit: ' : 'Patient: ') + patient
        }
      >
        <Stack fill align="center">
          <Stack.Item basis="140px">
            <Box bold fontSize="11px" color="label" mb="3px">
              Theme:
            </Box>
            <Dropdown
              width="130px"
              options={available_themes}
              selected={accessible_theme}
              onSelected={(value) => act('change_theme', { theme: value })}
            />
          </Stack.Item>
          <Stack.Item grow={1}>
            <Box textAlign="center">
              {ssd ? (
                <NoticeBox danger>Space sleep disorder detected!</NoticeBox>
              ) : null}
            </Box>
          </Stack.Item>
          <Stack.Item basis="140px">
            <Box bold fontSize="11px" color="label" mb="3px" textAlign="right">
              Help:
            </Box>
            <Button
              icon="info"
              tooltip="Most elements of this window have a tooltip for additional information. Hover your mouse over something for clarification!"
              color="transparent"
              fluid
            >
              Tooltips
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
      <Section>
        <LabeledList>
          <LabeledList.Item label="Health">
            <Tooltip
              content={
                'How healthy the patient is.' +
                (species === 'Synthetic Humanoid'
                  ? ''
                  : " If the patient's health dips below " +
                    crit_threshold +
                    '%, they enter critical condition and suffocate rapidly.') +
                " If the patient's health hits " +
                Math.round(dead_threshold / max_health) * 100 +
                '%, they die.'
              }
            >
              {health >= 0 ? (
                <ProgressBar
                  value={health / max_health}
                  ranges={{
                    good: [0.4, Infinity],
                    average: [0.2, 0.4],
                    bad: [-Infinity, 0.2],
                  }}
                />
              ) : (
                <ProgressBar
                  value={1 + health / max_health}
                  ranges={{
                    bad: [-Infinity, Infinity],
                  }}
                >
                  {Math.trunc((health / max_health) * 100)}%
                </ProgressBar>
              )}
            </Tooltip>
          </LabeledList.Item>
          {dead ? (
            <LabeledList.Item label="Revivable">
              <Box
                color={
                  revivable_boolean
                    ? accessible_theme
                      ? 'yellow'
                      : 'label'
                    : 'red'
                }
                bold
              >
                {revivable_string}
              </Box>
            </LabeledList.Item>
          ) : null}
          <LabeledList.Item label="Damage">
            <Tooltip
              content={
                species === 'Synthetic Humanoid'
                  ? 'Brute. Sustained from sources of physical trauma such as melee combat, firefights, etc. Repaired with a welding tool or surgery.'
                  : 'Brute. Sustained from sources of physical trauma such as melee combat, firefights, etc. Treated with Libital or sutures.'
              }
            >
              <Box inline>
                <ProgressBar value={0}>
                  Brute:{' '}
                  <Box inline bold color={'red'}>
                    {total_brute}
                  </Box>
                </ProgressBar>
              </Box>
            </Tooltip>
            <Box inline width={'5px'} />
            <Tooltip
              content={
                species === 'Synthetic Humanoid'
                  ? 'Burn. Sustained from sources of burning such as energy weapons, acid, fire, etc. Repaired with cable coils.'
                  : 'Burn. Sustained from sources of burning such as overheating, energy weapons, acid, fire, etc. Treated with Airui or regenerative mesh.'
              }
            >
              <Box inline>
                <ProgressBar value={0}>
                  Burn:{' '}
                  <Box inline bold color={'#ffb833'}>
                    {total_burn}
                  </Box>
                </ProgressBar>
              </Box>
            </Tooltip>
            <Box inline width={'5px'} />
            <Tooltip content="Toxin. Sustained from chemicals or organ damage. Treated with toxin healing medicine.">
              <Box inline>
                <ProgressBar value={0}>
                  Tox:{' '}
                  <Box inline bold color={'green'}>
                    {toxin}
                  </Box>
                </ProgressBar>
              </Box>
            </Tooltip>
            <Box inline width={'5px'} />
            <Tooltip content="Oxyloss. Sustained from being in critical condition, organ damage or extreme exhaustion. Treated with CPR, oxygen healing medicine or decreases on its own if the patient isn't in critical condition.">
              <Box inline>
                <ProgressBar value={0}>
                  Oxy:{' '}
                  <Box inline bold color={'blue'}>
                    {oxy}
                  </Box>
                </ProgressBar>
              </Box>
            </Tooltip>
          </LabeledList.Item>
          <LabeledList.Item label="Stamina">
            <Tooltip content="Stamina damage. Caused by stun weapons, exhaustion, or certain attacks. Regenerates over time or by resting.">
              <ProgressBar value={0}>
                Stamina:{' '}
                <Box inline bold color={'#9fb6c7'}>
                  {stamina}
                </Box>
              </ProgressBar>
            </Tooltip>
          </LabeledList.Item>
          <LabeledList.Item label="Species">
            <Box width="50px" bold color="#42bff5" nowrap maxWidth="100px">
              {species + (custom_species ? ' | ' + custom_species : ' ')}
            </Box>
          </LabeledList.Item>
          {majquirks ? (
            <LabeledList.Item label="Quirks">
              <Box width="100%">
                Subject Major Disabilities:{' '}
                <b className="quirks">{majquirks} </b>
              </Box>
            </LabeledList.Item>
          ) : null}
          {majquirks ? (
            <LabeledList.Item>
              <Box width="100%">
                Subject Minor Disabilities:{' '}
                <b className="quirks"> {minquirks} </b>
              </Box>
            </LabeledList.Item>
          ) : null}
          {brain_traumas && brain_traumas !== 'null' ? (
            <LabeledList.Item label="Brain Traumas" labelWrap>
              <Box width="100%" color="orange" bold>
                {brain_traumas}
              </Box>
            </LabeledList.Item>
          ) : null}
        </LabeledList>
      </Section>
    </>
  );
};

const PatientChemicals = () => {
  const { data } = useBackend<MedScannerData>();
  const { chemicals_lists } = data;
  const chemicals = Object.values(chemicals_lists);
  return (
    <Collapsible title="Chemical Contents">
      <Section>
        <LabeledList>
          {chemicals.map((chemical) => (
            <LabeledList.Item key={chemical.name}>
              <Tooltip
                content={
                  chemical.description +
                  (chemical.od
                    ? ' (OVERDOSING)'
                    : chemical.od_threshold > 0
                      ? ' (OD: ' + chemical.od_threshold + 'u)'
                      : '')
                }
              >
                <Box
                  inline
                  color={chemical.dangerous ? 'red' : 'white'}
                  bold={chemical.dangerous}
                >
                  {chemical.amount + 'u ' + chemical.name}
                </Box>
                <Box inline width={'5px'} />
                {chemical.od ? (
                  <Box inline color={'red'} bold>
                    {'OD'}
                  </Box>
                ) : null}
              </Tooltip>
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
    </Collapsible>
  );
};

const PatientLimbs = () => {
  const row_bg_color = 'rgba(255, 255, 255, .05)';
  let row_transparency = 0;
  const { data } = useBackend<MedScannerData>();
  const { limb_data_lists, species, accessible_theme } = data;
  const limb_data = Object.values(limb_data_lists);
  return (
    <Collapsible title="Limb Status">
      <Section>
        <Stack vertical fill>
          <Stack
            height="22px"
            mb="5px"
            pb="5px"
            style={{ borderBottom: '1px solid rgba(255, 255, 255, 0.1)' }}
          >
            <Stack.Item basis="95px" bold fontSize="12px" color="label">
              LIMB
            </Stack.Item>
            <Stack.Item basis="55px" bold fontSize="12px" color="red">
              BRUTE
            </Stack.Item>
            <Stack.Item basis="50px" bold fontSize="12px" color="#ffb833">
              BURN
            </Stack.Item>
            <Stack.Item
              grow={1}
              textAlign="right"
              fontSize="11px"
              color="label"
            >
              {'{ } = Untreated'}
            </Stack.Item>
          </Stack>
          {limb_data.map((limb) => (
            <Stack
              key={limb.name}
              width="100%"
              py="5px"
              px="3px"
              mb="2px"
              backgroundColor={row_transparency++ % 2 === 0 ? row_bg_color : ''}
              style={{
                borderRadius: '3px',
                border:
                  limb.missing || limb.limb_status || limb.bleeding
                    ? '1px solid rgba(255, 100, 100, 0.3)'
                    : '1px solid transparent',
              }}
            >
              <Stack.Item basis="95px" bold>
                <Icon
                  name={
                    limb.name.includes('head')
                      ? 'head-side-virus'
                      : limb.name.includes('chest')
                        ? 'heart-pulse'
                        : limb.name.includes('arm')
                          ? 'hand-paper'
                          : limb.name.includes('leg')
                            ? 'shoe-prints'
                            : 'circle'
                  }
                  mr={1}
                  color="label"
                />
                {limb.name[0].toUpperCase() + limb.name.slice(1)}
              </Stack.Item>
              {limb.missing ? (
                <Tooltip
                  content={
                    'Missing limbs can only be fixed through surgical intervention.'
                  }
                >
                  <Stack.Item>
                    <Box
                      px="8px"
                      py="3px"
                      backgroundColor="rgba(255, 0, 0, 0.25)"
                      color="red"
                      bold
                      style={{ borderRadius: '4px', border: '1px solid red' }}
                    >
                      <Icon name="exclamation-triangle" mr={1} />
                      MISSING
                    </Box>
                  </Stack.Item>
                </Tooltip>
              ) : (
                <>
                  <Stack.Item basis="55px">
                    <Tooltip
                      content={
                        limb.limb_type === 'Robotic'
                          ? 'Limb denting. Can be welded with a welding tool.'
                          : limb.bandaged
                            ? 'Treated wounds will slowly heal on their own, or can be healed faster with chemicals.'
                            : 'Untreated physical trauma. Can be bandaged with gauze or advanced trauma kits.'
                      }
                    >
                      <Box
                        inline
                        px="6px"
                        py="2px"
                        backgroundColor={
                          limb.brute > 30
                            ? 'rgba(255, 0, 0, 0.2)'
                            : limb.brute > 0
                              ? 'rgba(255, 0, 0, 0.1)'
                              : 'transparent'
                        }
                        color={
                          limb.brute > 30
                            ? 'red'
                            : limb.brute > 0
                              ? 'orange'
                              : 'white'
                        }
                        bold={limb.brute > 0}
                        style={{
                          borderRadius: '3px',
                          border:
                            limb.brute > 0
                              ? '1px solid rgba(255, 0, 0, 0.3)'
                              : 'none',
                        }}
                      >
                        {limb.bandaged ? (
                          <>
                            <Icon name="bandage" size={0.8} mr={0.5} />
                            {limb.brute}
                          </>
                        ) : limb.brute > 0 ? (
                          `{${limb.brute}}`
                        ) : (
                          limb.brute
                        )}
                      </Box>
                    </Tooltip>
                  </Stack.Item>
                  <Stack.Item basis="50px">
                    <Tooltip
                      content={
                        limb.limb_type === 'Robotic'
                          ? 'Wire scorching. Can be repaired with a cable coil.'
                          : limb.salved
                            ? 'Salved burns will slowly heal on their own, or can be healed faster with chemicals.'
                            : 'Unsalved burns. Can be salved with ointment or regenerative mesh.'
                      }
                    >
                      <Box
                        inline
                        px="6px"
                        py="2px"
                        backgroundColor={
                          limb.burn > 30
                            ? 'rgba(255, 184, 51, 0.25)'
                            : limb.burn > 0
                              ? 'rgba(255, 184, 51, 0.15)'
                              : 'transparent'
                        }
                        color={
                          limb.burn > 30
                            ? '#ffb833'
                            : limb.burn > 0
                              ? '#ffd699'
                              : 'white'
                        }
                        bold={limb.burn > 0}
                        style={{
                          borderRadius: '3px',
                          border:
                            limb.burn > 0
                              ? '1px solid rgba(255, 184, 51, 0.4)'
                              : 'none',
                        }}
                      >
                        {limb.salved ? (
                          <>
                            <Icon name="flask" size={0.8} mr={0.5} />
                            {limb.burn}
                          </>
                        ) : limb.burn > 0 ? (
                          `{${limb.burn}}`
                        ) : (
                          limb.burn
                        )}
                      </Box>
                    </Tooltip>
                  </Stack.Item>
                  <Stack.Item>
                    {limb.limb_status && limb.limb_status !== '' ? (
                      <Tooltip
                        content={
                          limb.limb_status === 'Splinted'
                            ? 'This fracture is stabilized by a splint, suppressing most of its symptoms. If this limb sustains damage, the splint might come off. It can be fully treated with surgery or cryo treatment.'
                            : 'This limb is broken. Use a splint to stabilize it. An unsplinted head, chest or groin will cause organ damage when the patient moves. Unsplinted arms or legs will frequently give out.'
                        }
                      >
                        <Box
                          inline
                          px="5px"
                          py="2px"
                          backgroundColor={
                            limb.limb_status === 'Splinted'
                              ? 'rgba(100, 255, 100, 0.15)'
                              : 'rgba(255, 100, 100, 0.15)'
                          }
                          color={
                            limb.limb_status === 'Splinted'
                              ? 'lime'
                              : limb.limb_status === 'Stabilized'
                                ? 'lime'
                                : 'orange'
                          }
                          bold
                          style={{ borderRadius: '3px' }}
                        >
                          <Icon
                            name={
                              limb.limb_status === 'Splinted'
                                ? 'bandage'
                                : 'bone-break'
                            }
                            mr={1}
                          />
                          {limb.limb_status}
                        </Box>
                      </Tooltip>
                    ) : null}
                    {limb.limb_type ? (
                      <Tooltip
                        content={
                          limb.limb_type === 'Robotic'
                            ? 'Robotic limbs are only fixed by welding or cable coils.'
                            : null
                        }
                      >
                        <Box
                          inline
                          color={
                            limb.limb_type === 'Robotic'
                              ? species === 'Synthetic Humanoid'
                                ? accessible_theme
                                  ? 'lime'
                                  : 'label'
                                : 'pink'
                              : 'tan'
                          }
                          bold
                        >
                          [{limb.limb_type}]
                        </Box>
                      </Tooltip>
                    ) : null}
                    {limb.bleeding ? (
                      <Tooltip content="This limb is bleeding and the patient is losing blood. Can be stopped with gauze or with a suture.">
                        <Box
                          inline
                          px="5px"
                          py="2px"
                          backgroundColor="rgba(255, 0, 0, 0.2)"
                          color="red"
                          bold
                          style={{
                            borderRadius: '3px',
                            animation: 'pulse 2s infinite',
                          }}
                        >
                          <Icon name="droplet" mr={1} />
                          Bleeding
                        </Box>
                      </Tooltip>
                    ) : null}
                  </Stack.Item>
                </>
              )}
            </Stack>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  );
};

const PatientOrgans = () => {
  const { data } = useBackend<MedScannerData>();
  const { damaged_organs } = data;
  return (
    <Collapsible title="Organs">
      <Section title="Organs Damaged">
        <LabeledList>
          {damaged_organs.map((organ) => (
            <LabeledList.Item
              key={organ.name}
              label={organ.name[0].toUpperCase() + organ.name.slice(1)}
            >
              <Tooltip content={organ.effects}>
                <Box
                  inline
                  color={organ.status === 'Midly Damaged' ? 'orange' : 'red'}
                  bold
                >
                  {organ.status === 'Missing'
                    ? organ.status
                    : organ.status +
                      ' with ' +
                      Math.ceil(organ.damage) +
                      ' damage'}
                </Box>
              </Tooltip>
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
    </Collapsible>
  );
};

const PatientBlood = () => {
  const { data } = useBackend<MedScannerData>();
  const { blood_amount, blood_type, body_temperature } = data;
  return (
    <Collapsible title="Blood & Temperature">
      <Section>
        <LabeledList>
          <LabeledList.Item label={'Blood Levels:'}>
            <Tooltip content="Bloodloss causes symptoms that start as suffocation and pain, but get significantly worse as more blood is lost. Blood can be restored by eating and taking Iron or temporarly by Saline.">
              <ProgressBar
                value={blood_amount / 560}
                ranges={{
                  blue: [Infinity, 0.8],
                  good: [0.8, 1],
                  red: [-Infinity, 0.8],
                }}
              />
            </Tooltip>
          </LabeledList.Item>
          <LabeledList.Item label={'Body Temperature'}>
            {body_temperature}
          </LabeledList.Item>
          <LabeledList.Item color="cyan" label={'Blood Type:'}>
            {blood_type}
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Collapsible>
  );
};

const PatientAdvice = () => {
  const { data } = useBackend<MedScannerData>();
  const { advice, species, accessible_theme } = data;
  return (
    <Collapsible title="Treatment Advice">
      <Section>
        <Stack vertical>
          {advice.map((advice) => (
            <Stack.Item key={advice.advice}>
              <Tooltip
                content={
                  advice.tooltip
                    ? advice.tooltip
                    : 'No tooltip entry for this advice.'
                }
              >
                <Box inline>
                  <Icon
                    name={advice.icon}
                    ml={0.2}
                    color={
                      accessible_theme
                        ? advice.color
                        : species === 'Synthetic Humanoid'
                          ? 'label'
                          : advice.color
                    }
                  />
                  <Box inline width={'5px'} />
                  {advice.advice}
                </Box>
              </Tooltip>
            </Stack.Item>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  );
};

const Wounds = () => {
  const { data } = useBackend<MedScannerData>();
  const { wounds } = data;

  return wounds ? (
    <Collapsible title="Wounds">
      <Section title="Wounds List">
        <Stack vertical>
          {wounds.map((wound) => (
            <Stack.Item
              key={wound.type}
              style={{
                background: 'rgba(36, 50, 67, 0.5)',
                padding: '10px',
                borderRadius: '1em',
                border: '3px solid grey',
                marginBottom: '10px',
                boxSizing: 'border-box',
              }}
            >
              <div
                style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  padding: '5px',
                  borderRadius: '1em',
                  background: 'rgba(36, 50, 67, 0.7)',
                  marginBottom: '10px',
                  boxSizing: 'border-box',
                }}
              >
                <Tooltip
                  content={
                    wound.description
                      ? wound.description
                      : 'No tooltip entry for this advice.'
                  }
                >
                  <div
                    style={{
                      flex: 1,
                      textAlign: 'center',
                    }}
                  >
                    {(wound.severity && wound.severity !== 'null'
                      ? wound.severity + ' '
                      : '') +
                      wound.type +
                      ' detected on ' +
                      wound.where}
                  </div>
                </Tooltip>
              </div>
              <div
                style={{
                  padding: '10px',
                  background: 'rgba(36, 50, 67, 0.3)',
                  borderRadius: '1em',
                  boxSizing: 'border-box',
                }}
              >
                {wound.recomended_treatement}
              </div>
            </Stack.Item>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  ) : null;
};

const MedicalAlerts = () => {
  const { data } = useBackend<MedScannerData>();
  const { medical_alerts } = data;

  const getSeverityColor = (severity: string) => {
    switch (severity) {
      case 'critical':
        return 'red';
      case 'warning':
        return 'orange';
      case 'info':
        return 'blue';
      default:
        return 'white';
    }
  };

  const getSeverityAnimation = (severity: string) => {
    if (severity === 'critical') {
      return { animation: 'pulse 2s infinite' };
    }
    return {};
  };

  return (
    <Collapsible title="⚠ Medical Alerts">
      <Section className="medical-alerts-section">
        <Stack vertical>
          {medical_alerts.map((alert, index) => (
            <Stack.Item key={index}>
              <NoticeBox
                color={getSeverityColor(alert.severity)}
                style={getSeverityAnimation(alert.severity)}
              >
                <Stack>
                  <Stack.Item>
                    <Icon
                      name={alert.icon}
                      size={2}
                      color={getSeverityColor(alert.severity)}
                    />
                  </Stack.Item>
                  <Stack.Item grow={1}>
                    <Box
                      bold={alert.severity === 'critical'}
                      fontSize={alert.severity === 'critical' ? '16px' : '14px'}
                    >
                      {alert.message}
                    </Box>
                  </Stack.Item>
                </Stack>
              </NoticeBox>
            </Stack.Item>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  );
};

const AlienEmbryo = () => {
  const { data } = useBackend<MedScannerData>();
  const { embryo_stage, damaged_organs } = data;

  // Find the embryo data from organs
  const embryo_data = damaged_organs.find((organ) => organ.is_embryo);
  if (!embryo_data) return null;

  return (
    <Section title="⚠ BIOHAZARD ALERT ⚠" className="alien-embryo-section" fill>
      <NoticeBox danger>
        <Stack vertical>
          <Stack.Item>
            <Box
              bold
              fontSize="18px"
              textAlign="center"
              color="red"
              style={{
                textShadow: '0 0 10px red',
                animation: 'pulse 2s infinite',
              }}
            >
              ☣ XENOMORPH PARASITE DETECTED ☣
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box textAlign="center" fontSize="16px" bold mt={1}>
              {embryo_data.status}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box mt={1} textAlign="center" italic>
              {embryo_data.effects}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <ProgressBar
              value={embryo_stage / 6}
              ranges={{
                bad: [0, 0.33],
                average: [0.33, 0.66],
                good: [0.66, Infinity],
              }}
              mt={1}
            >
              Gestation Progress: {Math.round((embryo_stage / 6) * 100)}%
            </ProgressBar>
          </Stack.Item>
          {embryo_stage >= 5 ? (
            <Stack.Item>
              <Box
                bold
                color="red"
                textAlign="center"
                mt={1}
                style={{
                  animation: 'blink 1s infinite',
                }}
              >
                ⚠ EMERGENCY SURGERY REQUIRED ⚠
              </Box>
            </Stack.Item>
          ) : null}
        </Stack>
      </NoticeBox>
    </Section>
  );
};

const Viruses = () => {
  const { data } = useBackend<MedScannerData>();
  const { viruses } = data;

  return (
    <Collapsible title="Diseases">
      <Section>
        <Stack>
          {viruses.map((virus) => (
            <Box
              key={virus.form}
              style={{
                padding: '10px',
                marginBottom: '10px',
                borderRadius: '8px',
                boxSizing: 'border-box',
              }}
            >
              <Box
                style={{
                  marginBottom: '5px',
                  fontWeight: 'bold',
                  fontSize: '16px',
                }}
              >
                <b className="virus_label"> {'Warning: '}</b>
                {virus.form + ' detected'}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="virus_label"> {'Name: '}</b>
                {virus.name}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="virus_label"> {'Type: '}</b>
                {virus.type}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="virus_label"> {'Stage: '} </b>
                {+virus.stage + '/' + virus.maxstage}
              </Box>
              <Box
                style={{
                  fontSize: '14px',
                }}
              >
                <b className="virus_label"> {'Possible Cure: '} </b>{' '}
                {virus.cure}
              </Box>
            </Box>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  );
};
