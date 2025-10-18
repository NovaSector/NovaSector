import {
  Box,
  Button,
  Collapsible,
  Icon,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

// import '../styles/interfaces/MedScanner.scss';

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
  revivable_boolean: boolean;
  revivable_string: number;
  chemicals_list: ChemicalData[];
  limb_data_list: LimbData[];
  damaged_organs: OrganData[];
  ssd: boolean;
  blood_type: string;
  blood_amount: number;
  body_temperature: string;
  advice: AdviceData[];
  accessible_theme: string;
  majquirks: string;
  minquirks: string;
  custom_species: string;
  wounds: WoundData[];
  brain_traumas: string | null;
  viruses: VirusData[];
  embryo_data: EmbryoData | null;
  medical_alerts: AlertData[];
};

type ChemicalData = {
  name: string;
  description: string;
  amount: number;
  od: boolean;
  od_threshold: number;
  dangerous: boolean;
};

type LimbData = {
  name: string;
  missing: boolean;
  brute: number;
  burn: number;
  limb_type: string;
  limb_status: string;
  bandaged: boolean;
  bleeding: boolean;
  infection: boolean;
  salved: boolean; // ???????
};

type OrganData = {
  name: string;
  status: string;
  damage: number;
  effects: string;
  is_embryo: boolean;
};

type WoundData = {
  type: string;
  where: string;
  severity: string;
  description: string;
  recomended_treatement: string;
};

type VirusData = {
  form: string;
  name: string;
  type: string;
  stage: number;
  maxstage: number;
  cure: string;
};

type AdviceData = {
  advice: string;
  tooltip: string;
  icon: string;
  color: number;
};

type EmbryoData = {
  embryo_stage: number;
  stage_desc: string;
};

type AlertData = {
  type: string;
  severity: string;
  message: string;
  icon: string;
};

export const MedScanner = () => {
  const { data } = useBackend<MedScannerData>();
  const {
    chemicals_list,
    limb_data_list,
    damaged_organs,
    blood_amount,
    advice,
    accessible_theme,
    wounds,
    viruses,
    medical_alerts,
  } = data;

  return (
    <Window width={515} height={615} theme={accessible_theme}>
      <Window.Content scrollable>
        <PatientBasics />
        <AlienEmbryo />
        {medical_alerts?.length ? <MedicalAlerts /> : null}
        {limb_data_list.length ? <PatientLimbs /> : null}
        {damaged_organs.length ? <PatientOrgans /> : null}
        {blood_amount ? <PatientBlood /> : null}
        {chemicals_list.length ? <PatientChemicals /> : null}
        {wounds.length ? <Wounds /> : null}
        {viruses.length ? <Viruses /> : null}
        <Quirks />
        {advice.length ? <PatientAdvice /> : null}
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

    revivable_boolean,
    revivable_string,

    ssd,

    accessible_theme,

    custom_species,
    brain_traumas,
  } = data;

  return (
    <Section
      title={
        (species === 'Synthetic Humanoid' ? 'Unit: ' : 'Patient: ') + patient
      }
      buttons={
        <Button
          icon="info"
          tooltip="Most elements of this window have a tooltip for additional information. Hover your mouse over something for clarification!"
          color="transparent"
          fluid
        >
          Tooltips
        </Button>
      }
    >
      <Stack fill align="center" pb="7px">
        {ssd ? (
          <Stack.Item grow={1}>
            <NoticeBox danger mb="0">
              Sudden sleep disorder detected!
            </NoticeBox>
          </Stack.Item>
        ) : null}
      </Stack>
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
        <LabeledList.Item label="Species">
          <Box width="50px" bold color="#42bff5" nowrap maxWidth="100px">
            {species + (custom_species ? ` | ${custom_species}` : ' ')}
          </Box>
        </LabeledList.Item>
        {brain_traumas && brain_traumas !== 'null' ? (
          <LabeledList.Item label="Brain Traumas" labelWrap>
            <Box width="100%" color="orange" bold>
              {brain_traumas}
            </Box>
          </LabeledList.Item>
        ) : null}
      </LabeledList>
    </Section>
  );
};

const PatientChemicals = () => {
  const { data } = useBackend<MedScannerData>();
  const { chemicals_list } = data;

  return (
    <Collapsible title="Chemical Contents">
      <Section>
        <LabeledList>
          {chemicals_list.map((chemical) => (
            <LabeledList.Item key={chemical.name}>
              <Tooltip
                content={
                  chemical.description +
                  (chemical.od
                    ? ' (OVERDOSING)'
                    : chemical.od_threshold > 0
                      ? ` (OD: ${chemical.od_threshold} u)`
                      : '')
                }
              >
                <Box
                  inline
                  color={chemical.dangerous ? 'red' : 'white'}
                  bold={chemical.dangerous}
                >
                  {`${chemical.amount}u ${chemical.name}`}
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
  const { limb_data_list, species, accessible_theme } = data;

  return (
    <Collapsible title="Limb Status">
      <Section>
        <Table>
          <Table.Row
            height="22px"
            mb="5px"
            pb="5px"
            style={{ borderBottom: '1px solid rgba(255, 255, 255, 0.1)' }}
          >
            <Table.Cell bold fontSize="12px" color="label">
              LIMB
            </Table.Cell>
            <Table.Cell bold fontSize="12px" color="red" textAlign="center">
              BRUTE
            </Table.Cell>
            <Table.Cell bold fontSize="12px" color="#ffb833" textAlign="center">
              BURN
            </Table.Cell>
          </Table.Row>
          {limb_data_list.map((limb) => (
            <Table.Row
              key={limb.name}
              width="100%"
              px="3px"
              backgroundColor={row_transparency++ % 2 === 0 ? row_bg_color : ''}
              style={{
                borderRadius: '3px',
                border:
                  limb.missing || limb.limb_status || limb.bleeding
                    ? '1px solid rgba(255, 100, 100, 0.3)'
                    : '1px solid transparent',
              }}
            >
              <Table.Cell width="130px" bold pl="3px" py="4px">
                <Stack style={{ gap: '0' }}>
                  <Stack.Item align="center" verticalAlign="middle">
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
                  </Stack.Item>
                  <Stack.Item>
                    {limb.name[0].toUpperCase() + limb.name.slice(1)}
                  </Stack.Item>
                </Stack>
              </Table.Cell>
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
                  <Table.Cell width="55px" verticalAlign="middle">
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
                  </Table.Cell>
                  <Table.Cell width="55px" verticalAlign="middle">
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
                  </Table.Cell>
                  <Table.Cell>
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
                          mx="2px"
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
                                : 'crutch'
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
                          mx="2px"
                          backgroundColor="rgba(255, 0, 0, 0.2)"
                          color="red"
                          bold
                          style={{
                            borderRadius: '3px',
                            animation: 'pulse 2s infinite',
                          }}
                          gr="true"
                        >
                          <Icon name="droplet" mr={1} height="auto" />
                          Bleeding
                        </Box>
                      </Tooltip>
                    ) : null}
                  </Table.Cell>
                </>
              )}
            </Table.Row>
          ))}
        </Table>
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
                    : `${organ.status} with ${Math.ceil(organ.damage)} damage`}
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
                    dangerouslySetInnerHTML={{
                      __html:
                        (wound.severity && wound.severity !== 'null'
                          ? `${wound.severity} `
                          : '') +
                        wound.type +
                        ' detected on ' +
                        wound.where,
                    }}
                  />
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
      <Section className="MedicalScanner__medical-alerts-section">
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
  const { embryo_data } = data;

  if (!embryo_data) return null;

  const { embryo_stage, stage_desc } = embryo_data;

  return (
    <Box className="MedicalScanner__alien-embryo-section" mb="6px">
      <NoticeBox danger mb="0px">
        <Stack vertical>
          <Stack.Item>
            <Box
              bold
              fontSize="18px"
              textAlign="center"
              color="red"
              style={{
                textShadow: '0 0 10px red',
                animation: 'danger-pulse 2s infinite',
              }}
            >
              ☣ XENOMORPH PARASITE DETECTED ☣
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box textAlign="center" fontSize="16px" bold mt={1}>
              {`Stage ${embryo_stage}/6 - ${stage_desc}`}
            </Box>
          </Stack.Item>
          <Stack.Item>
            <Box mt={1} textAlign="center" italic>
              BIOHAZARD: Xenomorph larva detected! Recommend immediate surgical
              removal or the patient will not survive.
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
                  animation: 'warning-blink 1s infinite',
                }}
              >
                ⚠ EMERGENCY SURGERY REQUIRED ⚠
              </Box>
            </Stack.Item>
          ) : null}
        </Stack>
      </NoticeBox>
    </Box>
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
                <b className="MedicalScanner__VirusLabel "> {'Warning: '}</b>
                {`${virus.form} detected`}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="MedicalScanner__VirusLabel "> {'Name: '}</b>
                {virus.name}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="MedicalScanner__VirusLabel "> {'Type: '}</b>
                {virus.type}
              </Box>
              <Box
                style={{
                  marginBottom: '5px',
                  fontSize: '14px',
                }}
              >
                <b className="MedicalScanner__VirusLabel"> {'Stage: '} </b>
                {`${+virus.stage}/${virus.maxstage}`}
              </Box>
              <Box
                style={{
                  fontSize: '14px',
                }}
              >
                <b className="MedicalScanner__VirusLabel ">
                  {' '}
                  {'Possible Cure: '}{' '}
                </b>{' '}
                {virus.cure}
              </Box>
            </Box>
          ))}
        </Stack>
      </Section>
    </Collapsible>
  );
};

const Quirks = () => {
  const { data } = useBackend<MedScannerData>();
  const { majquirks, minquirks } = data;

  return (
    <Collapsible title="Quirks">
      <Section>
        <Stack vertical>
          {majquirks ? (
            <Stack.Item>
              <Box width="100%">
                Subject Major Disabilities:{' '}
                <b className="MedicalScanner__Quirks">{majquirks} </b>
              </Box>
            </Stack.Item>
          ) : null}
          {majquirks ? (
            <Stack.Item>
              <Box width="100%">
                Subject Minor Disabilities:{' '}
                <b className="MedicalScanner__Quirks"> {minquirks} </b>
              </Box>
            </Stack.Item>
          ) : null}
        </Stack>
      </Section>
    </Collapsible>
  );
};
