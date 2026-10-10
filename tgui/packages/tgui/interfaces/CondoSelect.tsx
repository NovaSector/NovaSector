import { useEffect, useRef, useState } from 'react';
import {
  Box,
  Button,
  ColorBox,
  Dropdown,
  Icon,
  Image,
  ImageButton,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Archetype = {
  key: string;
  name: string;
  /** preview picture asset name (condo_<base>.png) */
  image: string;
};

type Room = {
  id: string;
  name: string;
  owner: string;
  map: string;
  private: BooleanLike;
  /** TRUE if this room belongs to the viewer */
  mine: BooleanLike;
};

type Data = {
  archetypes: Archetype[];
  pets: string[];
  ambiences: string[];
  rooms: Room[];
  /** lamp color the player picked via the color picker, echoed back from DM */
  picked_color: string;
};

const BRIGHTNESS_LEVELS = ['Off', 'Low', 'Normal', 'Bright'];

const LAMP_COLORS: { name: string; value: string }[] = [
  { name: 'Default', value: '' },
  { name: 'Warm', value: '#ffd6aa' },
  { name: 'White', value: '#ffffff' },
  { name: 'Sun', value: '#fff4c2' },
  { name: 'Red', value: '#ff6b6b' },
  { name: 'Orange', value: '#ffa94d' },
  { name: 'Green', value: '#69db7c' },
  { name: 'Cyan', value: '#66d9e8' },
  { name: 'Blue', value: '#74c0fc' },
  { name: 'Purple', value: '#b197fc' },
  { name: 'Pink', value: '#faa2c1' },
];

/** Interiors are all named "Condo - X"; the prefix is noise in a list/grid. */
function shortName(name: string): string {
  return name.replace(/^condo\s*-\s*/i, '').trim();
}

/**
 * Derived, client-side interior categories. There are no theme tags on the
 * templates, so we group by keywords in the name. A room can match more than
 * one bucket — that's fine for a filter. "All" always shows everything.
 */
const CATEGORIES: { key: string; label: string; icon: string; test: RegExp }[] =
  [
    { key: 'all', label: 'All', icon: 'border-all', test: /.*/ },
    { key: 'dorms', label: 'Dorms', icon: 'bed', test: /dorm/i },
    {
      key: 'cabins',
      label: 'Cabins',
      icon: 'campground',
      test: /cabin|lodge|snow|woods|serenity/i,
    },
    {
      key: 'homes',
      label: 'Homes',
      icon: 'building',
      test: /apartment|skyscraper|suite|manor|hilbert|hall|fortune/i,
    },
    {
      key: 'nature',
      label: 'Nature',
      icon: 'leaf',
      test: /beach|ocean|planar|soil|bog|pool|forest|garden/i,
    },
    {
      key: 'scifi',
      label: 'Sci-Fi',
      icon: 'rocket',
      test: /ds-?2|ship|deepspace|bridge|xeno|resin|pod|arrivals|station/i,
    },
    {
      key: 'odd',
      label: 'Oddities',
      icon: 'skull',
      test: /necropolis|alleyway|medieval|dragon|library/i,
    },
  ];

export function CondoSelect() {
  const [tab, setTab] = useState<'rooms' | 'create'>('rooms');
  const creating = tab === 'create';

  return (
    <Window
      title="Matrixed Teleportation Unit"
      width={creating ? 960 : 520}
      height={creating ? 720 : 560}
    >
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <Tabs fluid>
              <Tabs.Tab
                icon="door-open"
                selected={tab === 'rooms'}
                onClick={() => setTab('rooms')}
              >
                Open Rooms
              </Tabs.Tab>
              <Tabs.Tab
                icon="wand-magic-sparkles"
                selected={tab === 'create'}
                onClick={() => setTab('create')}
              >
                Create New
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Item grow style={{ minHeight: 0 }}>
            {creating ? (
              <CreateRoom />
            ) : (
              <RoomList onCreate={() => setTab('create')} />
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

function RoomList(props: { onCreate: () => void }) {
  const { act, data } = useBackend<Data>();
  const { rooms = [], archetypes = [] } = data;
  const [search, setSearch] = useState('');

  // rooms carry their template name in `map`; the archetype of the same name
  // carries its preview image — so we can show a thumbnail with zero DM cost.
  const imageForMap = (map: string): string | undefined => {
    const arch = archetypes.find((a) => a.name === map);
    return arch ? resolveAsset(arch.image) : undefined;
  };

  const query = search.toLowerCase();
  const shown = rooms
    .filter(
      (room) =>
        !query ||
        room.name.toLowerCase().includes(query) ||
        room.owner.toLowerCase().includes(query),
    )
    // your own rooms float to the top
    .sort((a, b) => Number(!!b.mine) - Number(!!a.mine));

  return (
    <Section
      title="Open Rooms"
      fill
      scrollable
      buttons={
        rooms.length > 0 && (
          <Input
            width="160px"
            placeholder="Search name or owner…"
            value={search}
            onChange={(value) => setSearch(value)}
          />
        )
      }
    >
      {rooms.length === 0 ? (
        <NoticeBox info>
          <Box>No private rooms are open right now.</Box>
          <Box mt={1}>
            <Button icon="plus" color="good" onClick={props.onCreate}>
              Create the first one
            </Button>
          </Box>
        </NoticeBox>
      ) : shown.length === 0 ? (
        <Box color="label" mt={1}>
          No rooms match “{search}”.
        </Box>
      ) : (
        shown.map((room) => (
          <ImageButton
            key={room.id}
            fluid
            imageSize={48}
            imageSrc={imageForMap(room.map)}
            fallbackIcon="house"
            tooltip="Enter this room"
            onClick={() => act('enter', { id: room.id })}
          >
            <Stack align="center">
              <Stack.Item grow>
                <Box bold>
                  {!!room.private && <Icon name="lock" mr={0.5} />}
                  {room.name}
                  {!!room.mine && (
                    <Box as="span" ml={0.5} color="good">
                      <Icon name="star" mr={0.25} />
                      Yours
                    </Box>
                  )}
                </Box>
                <Box color="label" fontSize={0.9}>
                  {shortName(room.map)} · by {room.owner}
                </Box>
              </Stack.Item>
              <Stack.Item color="label">
                <Icon name="right-to-bracket" />
              </Stack.Item>
            </Stack>
          </ImageButton>
        ))
      )}
    </Section>
  );
}

function CreateRoom() {
  const { act, data } = useBackend<Data>();
  const { archetypes = [], pets = [], ambiences = [], picked_color } = data;

  const [picked, setPicked] = useState<string | null>(null);
  const [category, setCategory] = useState('all');
  const [search, setSearch] = useState('');
  const [roomName, setRoomName] = useState('');
  const [isPrivate, setIsPrivate] = useState(false);
  const [password, setPassword] = useState('');
  const [brightness, setBrightness] = useState(2);
  const [lampColor, setLampColor] = useState('');
  const [ambience, setAmbience] = useState('None');
  const [pet, setPet] = useState('None');
  const [petName, setPetName] = useState('');
  const [zeroGrav, setZeroGrav] = useState(false);
  const [rotation, setRotation] = useState(0);

  // a color picked via the BYOND picker comes back through ui_data; sync it in
  const lastPicked = useRef(picked_color);
  useEffect(() => {
    if (picked_color && picked_color !== lastPicked.current) {
      lastPicked.current = picked_color;
      setLampColor(picked_color);
    }
  }, [picked_color]);

  const activeCategory =
    CATEGORIES.find((c) => c.key === category) ?? CATEGORIES[0];
  const query = search.toLowerCase();
  const visible = archetypes.filter((arch) => {
    const clean = shortName(arch.name);
    return (
      activeCategory.test.test(clean) &&
      (!query || clean.toLowerCase().includes(query))
    );
  });

  const activeKey = picked ?? visible[0]?.key ?? archetypes[0]?.key ?? null;
  const selectedArch = archetypes.find((a) => a.key === activeKey);
  const lightsOff = brightness === 0;
  const isPreset = LAMP_COLORS.some((c) => c.value === lampColor);
  // live preview feedback: dim the picture for low/off light, wash it in lamp color
  const darken = lightsOff ? 0.72 : brightness === 1 ? 0.4 : 0;

  const swatches = (
    <Box
      style={{
        display: 'flex',
        flexWrap: 'wrap',
        gap: '4px',
        opacity: lightsOff ? 0.35 : 1,
        pointerEvents: lightsOff ? 'none' : 'auto',
      }}
    >
      {LAMP_COLORS.map((swatch) => (
        <Box
          key={swatch.name}
          onClick={() => setLampColor(swatch.value)}
          style={{
            width: '22px',
            height: '22px',
            borderRadius: '4px',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: swatch.value || '#3a3a3a',
            color: '#111',
            border:
              lampColor === swatch.value
                ? '2px solid #69bfff'
                : '2px solid #222',
          }}
        >
          {!swatch.value && <Icon name="ban" size={0.9} />}
        </Box>
      ))}
    </Box>
  );

  return (
    <Stack fill vertical>
      {/* top: interior gallery (left) + live preview (right) */}
      <Stack.Item grow style={{ minHeight: 0 }}>
        <Stack fill>
          <Stack.Item grow style={{ minHeight: 0 }}>
            <Stack fill vertical>
              <Stack.Item>
                <Section fitted p={0.5}>
                  {CATEGORIES.map((cat) => (
                    <Button
                      key={cat.key}
                      icon={cat.icon}
                      selected={cat.key === category}
                      onClick={() => setCategory(cat.key)}
                    >
                      {cat.label}
                    </Button>
                  ))}
                </Section>
              </Stack.Item>
              <Stack.Item grow style={{ minHeight: 0 }}>
                <Section
                  title="Choose an interior"
                  fill
                  scrollable
                  buttons={
                    <Input
                      width="160px"
                      placeholder="Search…"
                      value={search}
                      onChange={(value) => setSearch(value)}
                    />
                  }
                >
                  {visible.length === 0 ? (
                    <Box color="label">No interiors match your filter.</Box>
                  ) : (
                    <Box
                      style={{
                        display: 'grid',
                        gridTemplateColumns:
                          'repeat(auto-fill, minmax(104px, 1fr))',
                        gap: '8px',
                        justifyItems: 'center',
                      }}
                    >
                      {visible.map((arch) => (
                        <ImageButton
                          key={arch.key}
                          imageSize={96}
                          imageSrc={resolveAsset(arch.image)}
                          selected={arch.key === activeKey}
                          tooltip={shortName(arch.name)}
                          onClick={() => setPicked(arch.key)}
                        >
                          <Box
                            style={{
                              width: '96px',
                              height: '2.4em',
                              overflow: 'hidden',
                              lineHeight: '1.2em',
                              textAlign: 'center',
                              fontSize: '0.72rem',
                            }}
                          >
                            {shortName(arch.name)}
                          </Box>
                        </ImageButton>
                      ))}
                    </Box>
                  )}
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          <Stack.Item width="460px">
            <Section
              title={selectedArch ? shortName(selectedArch.name) : 'Preview'}
              fill
              buttons={
                <Button
                  icon="arrows-rotate"
                  tooltip="Rotate preview"
                  onClick={() => setRotation((rotation + 90) % 360)}
                />
              }
            >
              <Box
                style={{
                  height: '100%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  overflow: 'hidden',
                }}
              >
                {selectedArch ? (
                  <Box style={{ position: 'relative', display: 'inline-flex' }}>
                    <Image
                      src={resolveAsset(selectedArch.image)}
                      style={{
                        maxWidth: '100%',
                        maxHeight: '100%',
                        objectFit: 'contain',
                        imageRendering: 'pixelated',
                        transform: `rotate(${rotation}deg)`,
                        transition: 'transform 0.15s',
                      }}
                    />
                    {darken > 0 && (
                      <Box
                        style={{
                          position: 'absolute',
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          background: '#000',
                          opacity: darken,
                          pointerEvents: 'none',
                        }}
                      />
                    )}
                    {!lightsOff && !!lampColor && (
                      <Box
                        style={{
                          position: 'absolute',
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          background: lampColor,
                          opacity: 0.25,
                          mixBlendMode: 'multiply',
                          pointerEvents: 'none',
                        }}
                      />
                    )}
                  </Box>
                ) : (
                  <Box color="label">No interiors available.</Box>
                )}
              </Box>
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>

      {/* bottom: full-width setup band — three cards, always fully visible */}
      <Stack.Item>
        <Stack>
          <Stack.Item grow basis="0">
            <Section fill title="Identity">
              <Stack vertical>
                <Stack.Item>
                  <Input
                    fluid
                    placeholder="Room name (blank = a default)"
                    value={roomName}
                    onChange={(value) => setRoomName(value)}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Stack align="center">
                    <Stack.Item>
                      <Button
                        icon={isPrivate ? 'lock' : 'lock-open'}
                        selected={isPrivate}
                        onClick={() => setIsPrivate(!isPrivate)}
                      >
                        {isPrivate ? 'Private' : 'Public'}
                      </Button>
                    </Stack.Item>
                    <Stack.Item grow>
                      <Input
                        fluid
                        placeholder="Password (optional)"
                        value={password}
                        disabled={!isPrivate}
                        onChange={(value) => setPassword(value)}
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>

          <Stack.Item grow basis="0">
            <Section fill title="Lighting">
              <Stack vertical>
                <Stack.Item>
                  <Box color="label" mb={0.5}>
                    Brightness
                  </Box>
                  <Stack>
                    {BRIGHTNESS_LEVELS.map((text, level) => (
                      <Stack.Item key={text}>
                        <Button
                          selected={brightness === level}
                          onClick={() => setBrightness(level)}
                        >
                          {text}
                        </Button>
                      </Stack.Item>
                    ))}
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Box color="label" mb={0.5}>
                    Lamp color
                  </Box>
                  <Stack align="center">
                    <Stack.Item grow>{swatches}</Stack.Item>
                    <Stack.Item>
                      <Button
                        disabled={lightsOff}
                        selected={!isPreset}
                        onClick={() => act('pick_color')}
                      >
                        <Box
                          style={{ display: 'inline-flex', alignItems: 'center' }}
                        >
                          <ColorBox color={lampColor || '#000000'} mr={0.5} />
                          Custom
                        </Box>
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>

          <Stack.Item grow basis="0">
            <Section fill title="Vibe & Companion">
              <Stack vertical>
                <Stack.Item>
                  <Stack align="center">
                    <Stack.Item color="label">Ambience</Stack.Item>
                    <Stack.Item grow>
                      <Dropdown
                        width="100%"
                        options={['None', ...ambiences]}
                        selected={ambience}
                        onSelected={(value) => setAmbience(value)}
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon={zeroGrav ? 'feather' : 'weight-hanging'}
                        selected={zeroGrav}
                        onClick={() => setZeroGrav(!zeroGrav)}
                      >
                        {zeroGrav ? 'Zero-G' : 'Gravity'}
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Stack align="center">
                    <Stack.Item color="label">Pet</Stack.Item>
                    <Stack.Item>
                      <Dropdown
                        width="110px"
                        options={['None', ...pets]}
                        selected={pet}
                        onSelected={(value) => setPet(value)}
                      />
                    </Stack.Item>
                    <Stack.Item grow>
                      <Input
                        fluid
                        placeholder="Pet name"
                        value={petName}
                        disabled={pet === 'None'}
                        onChange={(value) => setPetName(value)}
                      />
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>

        <Button
          fluid
          mt={1}
          icon="plus"
          color="good"
          textAlign="center"
          disabled={!activeKey}
          onClick={() =>
            act('create', {
              key: activeKey,
              name: roomName,
              private: isPrivate,
              password: isPrivate ? password : '',
              brightness,
              lamp_color: lampColor,
              ambience: ambience === 'None' ? null : ambience,
              pet: pet === 'None' ? null : pet,
              pet_name: petName,
              zero_grav: zeroGrav,
            })
          }
        >
          Create room
        </Button>
      </Stack.Item>
    </Stack>
  );
}
