# Proteans - Complete Documentation

## Overview

**Proteans** are nanomachine-based synthetic lifeforms that exist as a coherent swarm of metallic mass. They are walking factories that convert materials into more of themselves. Unlike traditional species, proteans cannot truly die - when critically damaged, they retreat into their modsuit core for protection and repair.

---

## Table of Contents

1. [Species Traits](#species-traits)
2. [Anatomy & Organs](#anatomy--organs)
3. [Metabolism & Survival](#metabolism--survival)
4. [Player Abilities](#player-abilities)
5. [Modsuit System](#modsuit-system)
6. [Servo Module System](#servo-module-system)
7. [Death & Revival](#death--revival)
8. [Medical Operations](#medical-operations)
9. [Cargo System](#cargo-system)
10. [Balance & Limitations](#balance--limitations)

---

## Species Traits

### Immunities & Resistances

- ✅ **TRAIT_NOBREATH**: Does not need to breathe
- ✅ **TRAIT_TOXIMMUNE**: Immune to all toxin damage
- ✅ **TRAIT_RADIMMUNE**: Immune to radiation
- ✅ **TRAIT_VIRUSIMMUNE**: Cannot contract diseases
- ✅ **TRAIT_NEVER_WOUNDED**: Cannot receive wounds
- ✅ **TRAIT_MADNESS_IMMUNE**: Immune to madness effects
- ✅ **TRAIT_RDS_SUPPRESSED**: Immune to RDS (Retinal Degeneration Syndrome)

### Unique Traits

- ✅ **TRAIT_NODEATH**: Cannot truly die - enters critical suit state instead
- ✅ **TRAIT_NOHUNGER**: Does not use traditional hunger system
- ✅ **TRAIT_ROCK_EATER**: Can consume rocks and minerals
- ✅ **TRAIT_EASYDISMEMBER**: Limbs are easily dismembered but can be reattached
- ✅ **TRAIT_LIMBATTACHMENT**: Can easily attach/detach limbs
- ✅ **TRAIT_STABLEHEART**: Heart always stable (handled by orchestrator module)
- ✅ **TRAIT_GENELESS**: No DNA - cannot be genetically modified
- ✅ **TRAIT_NO_HUSK**: Cannot be husked
- ✅ **TRAIT_NO_DNA_SCRAMBLE**: Immune to DNA scrambling
- ✅ **TRAIT_SYNTHETIC**: Recognized as synthetic lifeform
- ✅ **TRAIT_SILICON_EMOTES_ALLOWED**: Can use silicon emotes

### Vulnerabilities

- ⚠️ **Electrical Sensitivity**: Takes 1.5x damage from electricity (siemens_coeff = 1.5)
- ⚠️ **Fragile Construction**: Limbs have low HP (40 HP arms/legs, 120 HP head, core chest)
- ⚠️ **Metal Dependency**: Must consume metal to survive
- ⚠️ **Limited Organ Options**: Can only use specific protean organs

---

## Anatomy & Organs

Proteans have a highly specialized organ system with only 6 organ types (4 vital):

### 1. Protean Core (Brain) ⭐ VITAL

**Type:** `/obj/item/organ/brain/protean`
**Location:** Chest
**Icon:** "posi1" (advanced positronic brain)

**Functions:**

- Houses the protean's consciousness and AI
- Manages the entire nanite swarm
- Monitors refactory and orchestrator status
- Triggers suit retreat when entering hard crit
- Handles organ rejection for non-compatible organs
- Controls revival system

**Special Mechanics:**

- Rejects organic organs (only accepts ORGAN_ROBOTIC, ORGAN_NANOMACHINE, or ORGAN_UNREMOVABLE)
- Cannot be removed or damaged in traditional ways
- Survives even when protean "dies"

### 2. Refactory (Stomach) ⭐ VITAL

**Type:** `/obj/item/organ/stomach/protean`
**Icon:** "refactory"

**Functions:**

- Stores metal (max 10 sheets)
- Processes metal into nanite mass
- Handles passive healing
- Manages blood volume regeneration
- Powers the entire protean

**Metabolism Details:**

- **Base Consumption:** 1 metal sheet per ~2000 seconds (PROTEAN_METABOLISM_RATE)
- **Healing Mode:** +20x consumption when healing damage
- **Blood Regen Mode:** +100x consumption when regenerating blood
- **Low Power Mode:** 1/16th normal consumption (via Low Power Mode ability)
- **Passive Healing:** Heals 2 brute/burn per tick when above 30% metal and damaged

**Metal Storage:**

- **Full:** 10 sheets (100%)
- **Operational:** 0.5+ sheets (safe operation)
- **Starving:** < 0.5 sheets (slowed, taking damage)
- **Empty:** 0 sheets (major slowdown, constant damage)

**Special Mechanics:**

- Automatically processes food into nothing (nutrition_factor = 0)
- Only accepts golem food (metal sheets)
- Being fed by others = instant 20 brute heal + 1 metal
- Self-feeding = 1 metal only

### 3. Orchestrator Module (Heart) ⭐ VITAL (for mobility)

**Type:** `/obj/item/organ/heart/protean`
**Icon:** "orchestrator"

**Functions:**

- Parallel processor for movement coordination
- Prevents knockdowns and movement penalties

**Without Orchestrator:**

- Constant knockdowns every 30 seconds
- 2x movement slowdown
- Makes walking extremely difficult

### 4. Imaging Nanites (Eyes)

**Type:** `/obj/item/organ/eyes/robotic/protean`

**Functions:**

- Standard robotic vision
- Can be healed/replaced via "Heal Organs and Limbs" ability

### 5. Sensory Nanites (Ears)

**Type:** `/obj/item/organ/ears/cybernetic/protean`

**Functions:**

- Standard hearing
- Can be healed/replaced via "Heal Organs and Limbs" ability

### 6. Audio Fabricator (Tongue)

**Type:** `/obj/item/organ/tongue/cybernetic/protean`

**Functions:**

- Vibrating nanites for speech
- Can be healed/replaced via "Heal Organs and Limbs" ability

### 7. Reagent Catalyst (Liver)

**Type:** `/obj/item/organ/liver/protean`

**Functions:**

- Processes chemicals for the nanite swarm
- Does NOT filter toxins (proteans are immune)
- Permanent organ (ORGAN_UNREMOVABLE)

---

## Metabolism & Survival

### Metal Consumption System

Proteans consume metal instead of food to maintain their nanite mass.

**How to Feed:**

1. Pick up metal sheets (`/obj/item/stack/sheet/iron`)
2. Click on yourself or use the eat action
3. Metal is converted to "golem food" and stored in refactory

**Consumption Rates:**

- **Idle:** ~0.005 sheets/second (1 sheet per ~200 seconds)
- **Healing:** Up to ~0.1 sheets/second when actively regenerating
- **Blood Regen:** Up to ~0.5 sheets/second when recovering blood
- **Low Power:** 1/16th of normal rate (extreme conservation)

**Starvation Effects:**

- **7-10 sheets:** Optimal, passive healing enabled
- **3-7 sheets:** Normal operation
- **0.5-3 sheets:** Operational but no healing
- **< 0.5 sheets:** Starving! 2x slowdown + constant 2 brute damage
- **0 sheets:** Massive slowdown, rapid deterioration

### Passive Healing

When metal > 30% (3+ sheets) and damaged:

- Heals **2 brute and 2 burn per tick**
- Costs **+20x metal consumption**
- Has **30 second cooldown** after taking damage (REGEN_TIME)
- Healing amount scales with cooldown progress

### Blood Regeneration

When blood volume < normal (560u):

- Regenerates blood automatically
- Costs **+100x metal consumption**
- Very expensive - uses metal rapidly
- Stops when blood reaches normal levels

---

## Player Abilities

All protean abilities are accessed via the **"Protean" tab** in the command bar.

### 1. Open Suit UI

**Verb:** `protean_ui()`
**Hotkey:** None

**Description:**
Opens the modsuit control interface for your protean modsuit.

**Usage:**

- Click to open MOD control UI
- Shows module status
- Shows charge level (metal storage)
- Access to suit controls

---

### 2. Heal Organs and Limbs

**Verb:** `protean_heal()`
**Hotkey:** None
**Cost:** 6 metal sheets (60% of max storage)
**Requirements:** Must be inside modsuit

**Description:**
Completely repairs all damage, organs, and limbs using stored metal.

**What It Heals:**

- ✅ All brute damage
- ✅ All burn damage
- ✅ All limb damage
- ✅ Missing/damaged eyes
- ✅ Missing/damaged ears
- ✅ Missing/damaged tongue
- ✅ Missing/damaged liver
- ✅ Reattaches all missing limbs

**How to Use:**

1. Enter your modsuit (use "Toggle Suit Transformation")
2. Ensure you have 6+ metal sheets
3. Activate "Heal Organs and Limbs"
4. Wait 30 seconds
5. Fully healed!

**Restrictions:**

- Cannot use while outside suit
- Requires 60% metal (6 sheets minimum)
- Cannot use while incapacitated (unless in suit)
- Does NOT restore the refactory or orchestrator (must order from cargo)

---

### 3. Toggle Suit Transformation

**Verb:** `suit_transformation()`
**Hotkey:** None
**Duration:** 5 seconds

**Description:**
Enter or exit your modsuit, transforming between humanoid form and suit-stored form.

**Entering Suit (Humanoid → Suit):**

- Takes 5 seconds
- Protean becomes invisible (invisibility = 101)
- Plays transformation animation
- Protean is moved inside the modsuit
- Stunned indefinitely while inside
- Gains environmental protection traits
- Low power mode is automatically disabled
- Suit drops to the ground

**Exiting Suit (Suit → Humanoid):**

- Takes 5 seconds
- Must not be incapacitated (unless using ability while dead)
- Plays transformation animation
- Protean reforms at suit location
- Applies 7-second "Freshly Reformed" debuff
- Automatically equips suit to back slot
- Adds TRAIT_NODROP to suit

**While in Suit:**

- Protected from all environmental damage
- Cannot move
- Can still use abilities and communicate
- Modsuit can be picked up/moved
- Suit UI still accessible

**Special Cases:**

- If suit is in storage, exits to storage location
- If suit is being worn by someone, exits to that location
- Cannot exit if "dead" (refactory destroyed)

**Reformed Debuff:**

- Duration: 7 seconds
- Effects: 2x damage taken (-100 damage resistance)
- Movement slowdown (5x multiplicative)
- Cannot be removed early

---

### 4. Lock Suit

**Verb:** `lock_suit()`
**Hotkey:** None

**Description:**
Locks or unlocks your modsuit. When locked on another person, they cannot remove it.

**Usage:**

- Click to toggle lock state
- Shows message: "You lock/unlock the suit"
- Makes click sound

**When Locked on Others:**

- Target cannot remove the suit (TRAIT_NODROP)
- Target cannot undeploy suit parts
- Target cannot deactivate the suit
- Only the protean can unlock it

**When Locked (Self):**

- Suit cannot be removed from your back
- Normal modsuit operation

**Unlocking:**

- Use Lock Suit verb again
- Forced unlock on OOC escape/safeword

---

### 5. Toggle Low Power Mode

**Verb:** `low_power()`
**Hotkey:** None
**Activation Time:** 2.5 seconds
**Metal Consumption:** 1/16th normal rate

**Description:**
Drastically reduces metal consumption at the cost of severe movement penalties.

**Benefits:**

- Metal consumption reduced to 6.25% of normal
- Can idle for extremely long periods
- Useful when metal is scarce
- Automatic in suit form

**Penalties:**

- **5x movement slowdown** (multiplicative_slowdown = 5)
- Extremely slow movement
- Cannot activate modsuit while in low power
- Must deactivate to use suit

**Restrictions:**

- Cannot toggle while in suit form
- Requires refactory (stomach)
- 2.5 second activation delay
- Can be interrupted

**Strategic Use:**

- Enable when metal is low
- Disable before combat/movement
- Automatically disabled when entering suit

---

## Modsuit System

### Protean Modsuit

**Type:** `/obj/item/mod/control/pre_equipped/protean`
**Slot:** Back (ITEM_SLOT_BACK)
**Removal:** Cannot be removed (TRAIT_NODROP)

**Features:**

- Functions as standard MOD control unit
- Uses metal storage instead of battery
- Can assimilate other modsuits
- Lava/fire/acid proof
- Cannot be dropped normally
- Cannot be emagged
- Core cannot be removed

### Modsuit Core

**Type:** `/obj/item/mod/core/protean`
**Charge Source:** Refactory (stomach organ)

**Charge System:**

- Uses metal from refactory instead of power cells
- Charge = current metal in stomach
- Max charge = 10 (PROTEAN_STOMACH_FULL)
- Minimum operation = 0.5 metal (PROTEAN_STOMACH_FALTERING)

**Charge Display:**

- **Green (Good):** 7-10 sheets (70%+)
- **Yellow (Average):** 3-7 sheets (30-70%)
- **Red (Bad):** 0-3 sheets (0-30%)
- **Missing:** No refactory installed

**Special Behavior:**

- Cannot add charge manually
- Cannot subtract charge manually
- Automatically checks refactory status
- Returns FALSE when protean is "dead"

### Modsuit Assimilation

Proteans can absorb other modsuits to use their modules and appearance.

**How to Assimilate:**

1. Obtain another modsuit (`/obj/item/mod/control`)
2. Deactivate your protean suit
3. Use the other modsuit on your protean suit
4. Wait 4 seconds
5. Modsuit absorbed!

**What Happens:**

- Other modsuit is consumed and stored internally
- Your suit takes on the appearance of absorbed suit
- All modules from absorbed suit are transferred
- Your suit inherits the name/description/theme
- Storage modules are cached (not replaced)

**Restrictions:**

- Cannot assimilate while suit is active
- Cannot assimilate another protean suit
- Cannot assimilate infiltrator suits
- Can only store one modsuit at a time

**Removing Assimilated Suit:**

1. Use "Remove Assimilated Modsuit" verb
2. OR deactivate suit and wait 4 seconds
3. Suit is ejected to your hand
4. Your modsuit returns to original appearance

### Modsuit Theme Copying

Proteans can copy the appearance of modsuit platings without absorbing the full suit.

**How to Copy:**

1. Obtain MOD plating (`/obj/item/mod/construction/plating`)
2. Deactivate your suit
3. Use plating on your protean suit
4. Wait 4 seconds
5. Plating consumed, theme copied!

**Effects:**

- Your suit's appearance changes to match plating
- Only visual - doesn't add modules
- Plating is destroyed in process
- Can be changed again with different plating

---

## Servo Module System

The **Protean MOD Servo Module** is a special module that grants abilities to the protean when worn by someone else.

### Installation

**Type:** `/obj/item/mod/module/protean_servo`
**Complexity:** 3
**Energy Cost:** Default charge drain

**Requirements:**

- Must be installed in protean's modsuit
- Module must be activated
- Protean must be inside the suit
- Someone else must be wearing the suit

### How It Works

1. Another person wears the protean's modsuit
2. Protean is inside the suit (in "suit form")
3. Module is activated via MOD UI
4. Protean gains 3 action buttons
5. Protean can buff the wearer using these abilities

### Servo Abilities

All abilities share a **60-second cooldown** (using one triggers cooldown on all three).

#### Ability 1: Enhance Movement

**Cooldown:** 60 seconds (shared)
**Duration:** 7 seconds

**Wearer Effects:**

- ✅ **-0.4 movement speed** (much faster)
- ❌ **Hands restrained** (cannot use items)
- ❌ **Easier to grab** (more vulnerable)
- ℹ️ Items locked in hands (won't drop)

**Best Used For:**

- Quick escapes
- Running to objectives
- Chasing targets
- Closing distance

#### Ability 2: Enhance Medical Actions

**Cooldown:** 60 seconds (shared)
**Duration:** 20 seconds

**Wearer Effects:**

- ✅ **2x surgery speed** (0.5x surgery time)
- ✅ **TRAIT_FASTMED** (faster medicine application)
- ✅ **TRAIT_QUICKER_CARRY** (faster patient carrying)

**Best Used For:**

- Emergency surgeries
- Quick medical treatment
- Carrying wounded to medbay
- Mass casualty response

#### Ability 3: Enhance Building

**Cooldown:** 60 seconds (shared)
**Duration:** 20 seconds

**Wearer Effects:**

- ✅ **-0.35 action speed** (faster tool use)
- ✅ **TRAIT_QUICK_BUILD** (faster construction)

**Best Used For:**

- Engineering repairs
- Building structures
- Hacking doors
- Deconstruction work

### Servo Strategy

**Team Synergy:**

- Protean acts as "power armor" for another crew member
- Protean controls when to activate buffs
- Wearer gets powerful temporary abilities
- Works best with coordinated teamwork

**Example Scenarios:**

- Combat Medic: Doctor wears protean, uses medical buff for triage
- Engineering Response: Engineer wears protean, uses building buff for repairs
- Security Chase: Officer wears protean, uses movement buff to catch criminals

---

## Player Abilities

### Verb Summary Table

| Verb                           | Category | Cooldown | Cost    | Description                       |
| ------------------------------ | -------- | -------- | ------- | --------------------------------- |
| **Open Suit UI**               | Protean  | None     | None    | Opens modsuit interface           |
| **Heal Organs and Limbs**      | Protean  | 30s      | 6 metal | Full heal while in suit           |
| **Toggle Suit Transformation** | Protean  | None     | None    | Enter/exit modsuit                |
| **Lock Suit**                  | Protean  | None     | None    | Lock suit on wearer               |
| **Toggle Low Power Mode**      | Protean  | 2.5s     | None    | Reduce consumption, slow movement |
| **Servo: Movement**            | Protean  | 60s      | Energy  | Buff wearer's speed               |
| **Servo: Medical**             | Protean  | 60s      | Energy  | Buff wearer's medical abilities   |
| **Servo: Engineering**         | Protean  | 60s      | Energy  | Buff wearer's construction        |

---

## Death & Revival

### "Death" Mechanics

Proteans cannot truly die due to TRAIT_NODEATH. Instead, they have a unique critical failure state.

### Entering Critical State

**Trigger:** Health drops to HARD_CRIT level

**What Happens:**

1. Message: "Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."
2. `dead` flag set to TRUE
3. Protean is fully healed (to prevent double-death)
4. **Refactory (stomach) is destroyed**
5. Protean automatically retreats into modsuit (forced)
6. TRAIT_CRITICAL_CONDITION added (shows on crew monitor)

**Critical State Effects:**

- Cannot exit suit
- Cannot heal
- Cannot use abilities
- Shows as critical on crew monitoring
- Metal counter shows "missing"
- Suit UI shows repair needed

### Revival Process

**Requirements:**

- New refactory organ (`/obj/item/organ/stomach/protean`)
- Someone to help (protean cannot self-revive)
- Screwdriver to open suit

**Steps:**

1. **Examine** the protean suit - shows "requires critical repairs"
2. **Screwdriver** the suit to open it (set `open = TRUE`)
3. **Insert new refactory** into the open suit
4. **Wait 5 minutes** for automatic revival

**During Revival:**

- Suit shows "Repairing systems..."
- Brain's `revive_timer()` proc counts down
- After 5 minutes: protean fully heals and can exit

**Alternative: Memory Reset**

- Use a **pen** on the dead protean suit
- Resets their memory (RP mechanic)
- Forces 5 second sleep
- Logs as memory wipe in attack logs

### Examining Dead Proteans

**Closed Suit:**

> "This Protean requires critical repairs! Screwdriver them open... There does seem to be a tiny reset hole on the top of the Protean, it seems a Pen might fit in there.."

**Opened Suit (No Refactory):**

> "Insert a new refactory"

**Opened Suit (With Refactory):**

> "Refactory Installed! Repairing systems..."

**AFK Detection:**

> "[They] [have] entered stasis and [have] been completely unresponsive to anything for X minutes. [They] may snap out of it soon."

**Disconnect Detection:**

> "[They] [are] totally listless. The stresses of life in deep-space must have been too much for [them]. Any recovery is unlikely."

---

## Medical Operations

### Protean-Specific Surgeries

#### Organ Replacement Surgery

Since proteans reject organic organs, all organ replacements must use protean-specific organs:

**Compatible Organs:**

- `/obj/item/organ/stomach/protean` - Refactory ⭐
- `/obj/item/organ/heart/protean` - Orchestrator ⭐
- `/obj/item/organ/eyes/robotic/protean`
- `/obj/item/organ/ears/cybernetic/protean`
- `/obj/item/organ/tongue/cybernetic/protean`
- `/obj/item/organ/liver/protean` (permanent)

**Organ Rejection:**
If you try to insert non-protean organs:

- Organ is automatically rejected after 1 second
- Message: "Your mass rejected [organ]!"
- Organ is expelled to the ground
- Only ORGAN_ROBOTIC, ORGAN_NANOMACHINE, or ORGAN_UNREMOVABLE are accepted

#### Critical Care (Dead Protean)

**Situation:** Protean is "dead" (in critical suit state)

**Procedure:**

1. Screwdriver the protean suit (opens it)
2. Insert new refactory (`/obj/item/organ/stomach/protean`)
3. Wait 5 minutes for auto-revival
4. Protean revives and can exit suit

**Alternative: Memory Reset**

1. Use pen on the dead protean suit
2. Wait 10 seconds
3. Memory is reset (RP consequence)

#### Self-Healing (Protean Ability)

Instead of surgery, proteans can self-heal:

1. Enter modsuit
2. Use "Heal Organs and Limbs" verb
3. Costs 6 metal, takes 30 seconds
4. Fully repairs everything

---

## Cargo System

### Supply Packs

#### Protean Organs Crate

**Type:** `/datum/supply_pack/science/protean_organs`
**Cost:** Standard cargo value
**Access Required:** ACCESS_ROBOTICS
**Crate Type:** Secure science robotics crate

**Contents:**

- 2x Refactory (stomach organ)
- 2x Orchestrator (heart organ)

**Use Cases:**

- Revival of dead proteans
- Replacement for destroyed organs
- Emergency medical supplies

#### Protean Vessel Crate

**Type:** `/datum/supply_pack/science/protean_vessel`
**Cost:** 5x standard cargo value
**Access Required:** ACCESS_ROBOTICS
**Crate Type:** Secure science robotics crate

**Contents:**

- 1x Empty protean body (`/mob/living/carbon/human/species/protean/empty`)

**Vessel Details:**

- Spawns with 250 brute damage (critical state)
- NO brain installed
- NO orchestrator installed
- Refactory present but very weak
- Designed for brain transplants

**Use Cases:**

- Body replacement for dead proteans
- Positronic brain installation
- MMI integration
- Emergency backup bodies

---

## Advanced Mechanics

### Limb Damage & Dismemberment

**Limb HP:**

- Head: 120 HP
- Chest: Core HP (LIMB_MAX_HP_CORE)
- Arms: 40 HP each
- Legs: 40 HP each

**Dismemberment Behavior:**

- Limbs dismember when damage ≥ max_damage
- Dismembered limbs exist for 30 seconds (PROTEAN_LIMB_TIME)
- Auto-delete after 30 seconds
- Can be reattached before deletion
- Reattaching cancels deletion timer

**Damage Messages:**

- **Light Brute:** "scratched"
- **Medium Brute:** "festering"
- **Heavy Brute:** "falling apart"
- **Light Burn:** "scorched"
- **Medium Burn:** "melted"
- **Heavy Burn:** "boiling"

### Modsuit Stripping

**Normal Stripping (Non-Protean Wearer):**

- Suit can be removed normally
- TRAIT_NODROP is removed temporarily

**Protean Stripping (Protean Wearer):**

- Cannot remove suit (it's part of them)
- Instead, empties internal storage
- Uses custom strip menu
- Requires Ctrl+Shift+Click

**Strip Menu Access:**

- Ctrl+Shift+Click on protean suit
- Shows custom strip interface
- Can remove items from storage
- Cannot remove suit itself

### EMP Effects

Proteans are vulnerable to EMPs despite being synthetic:

**Heavy EMP:**

- Message: "Your core nanites buzz erratically/surge chaotically!"
- Drugginess: 40 seconds
- Disrupts coordination

**Light EMP:**

- Message: "Your core nanites feel fuzzy/unruly/sluggish."
- Drugginess: 20 seconds
- Minor disruption

### Missing Organs Effects

#### Without Refactory (Stomach):

- **Constant damage:** 3 brute every tick
- **Warning:** "Your mass is slowly degrading without your refactory!"
- **Death:** Eventually leads to hard crit → suit retreat

#### Without Orchestrator (Heart):

- **Knockdowns:** Constant falling every 30 seconds
- **Movement penalty:** 2x slowdown
- **Warning:** "You're struggling to walk without your orchestrator!"
- **Not fatal** but extremely debilitating

#### Without Eyes/Ears/Tongue/Liver:

- Standard organ loss effects (blindness, deafness, mute, etc.)
- Can be healed with "Heal Organs and Limbs" ability
- Not immediately fatal

---

## Balance & Limitations

### Advantages

✅ **Extreme Durability**

- Cannot die permanently
- Auto-retreats to suit when critical
- Can fully self-heal with metal
- Immune to most damage types

✅ **Utility**

- Can serve as mobile power armor
- Servo modules provide team buffs
- Can assimilate different modsuit types
- Self-sufficient with metal supply

✅ **Flexibility**

- Can enter/exit suit at will
- Low power mode for conservation
- Easy limb reattachment
- Multiple role support via servo modules

### Disadvantages

❌ **Economic**

- 30% reduced paychecks (payday_modifier = 0.7)

❌ **Combat Fragility**

- Very low limb HP (40 per limb)
- 1.5x electrical damage
- Easy to dismember
- Double damage when freshly reformed

❌ **Resource Dependency**

- Requires constant metal supply
- Cannot use normal food
- Healing costs 6 metal sheets
- Expensive to maintain when damaged

❌ **Medical Limitations**

- Cannot receive organic organ transplants
- Limited organ options (cargo only)
- Cannot use traditional healing items
- Requires specialized care when "dead"

❌ **Mobility Restrictions**

- 5x slowdown in low power mode
- 2x slowdown without orchestrator
- 7-second debuff after reforming
- Cannot move while in suit form

---

## Status Effects

### Low Power Mode

**ID:** `proteanlowpower`
**Icon:** `protean_lowpower`

**Effects:**

- 5x movement slowdown
- 1/16th metal consumption
- Cannot activate modsuit
- Removed when entering suit

### Freshly Reformed

**ID:** `proteanlowpower` (reform variant)
**Icon:** `protean_reform`
**Duration:** 7 seconds

**Effects:**

- 2x damage taken (-100 damage resistance)
- 5x movement slowdown
- Applied when exiting suit
- Cannot be removed early

### Servo Movement Buff

**ID:** `protean_servo_movement`
**Duration:** 7 seconds
**Cooldown:** 60 seconds (shared)

**Effects:**

- -0.4 movement speed (faster)
- Hands restrained (cannot use)
- Items locked in hands

### Servo Medical Buff

**ID:** `protean_servo_medical`
**Duration:** 20 seconds
**Cooldown:** 60 seconds (shared)

**Effects:**

- 2x surgery speed
- TRAIT_FASTMED
- TRAIT_QUICKER_CARRY

### Servo Engineering Buff

**ID:** `protean_servo_engineer`
**Duration:** 20 seconds
**Cooldown:** 60 seconds (shared)

**Effects:**

- -0.35 action speed
- TRAIT_QUICK_BUILD

---

## Interactions & Special Cases

### Eating Mechanics

**Compatible Foods:**

- Metal sheets (`/obj/item/food/golem_food`)
- Processed via COMSIG_CARBON_ATTEMPT_EAT signal
- Instantly converted to 1 metal sheet
- Bypasses normal food system

**Eating Restrictions:**

- Cannot eat if storage is full (> 9.7 sheets)
- Balloon alert: "storage full!"

**Being Fed by Others:**

- Grants 1 metal sheet
- **Bonus:** Instant 20 brute heal
- Message: "healed!" or "fully healed!"
- Does not require empty hands

### Outfit Equipment

When proteans are equipped with job outfits:

**Special Handling:**

1. If outfit has modsuit - automatically assimilated
2. Outfit backpack contents moved to suit storage
3. Storage module added if missing
4. 20 metal sheets added to inventory automatically

**Job Compatibility:**

- Works with all jobs
- Modsuit-based jobs have suits assimilated
- Storage items transferred to modsuit storage
- Standard items equipped normally

### Suit Interactions

**Wearing the Protean (Non-Protean):**

- Can wear like normal modsuit
- Modsuit functions normally
- Can be locked by protean (cannot remove)
- Servo module provides buffs if active

**OOC Escape/Safeword:**

- Automatically drops suit
- Unlocks if locked
- Triggered by COMSIG_OOC_ESCAPE signal

---

## Technical Details

### Blood Type

**Type:** BLOOD_TYPE_NANITE_SLURRY ("NS")

- Cannot receive normal blood
- Regenerates blood using metal
- Very expensive (100x consumption rate)

### Bodytype

**Type:** BODYTYPE_NANO

- Unique bodytype for nanomachine construction
- Affects clothing compatibility
- Recognized as synthetic

### Reagent Processing

**Flag:** PROCESS_PROTEAN

- Only processes reagents marked as PROTEAN compatible
- Liver distributes chemicals to nanite swarm
- Does not filter toxins (immune anyway)

### Digitigrade Support

**Setting:** DIGITIGRADE_OPTIONAL

- Can choose normal or digitigrade legs
- Digitigrade variants available
- Uses BODYPART_ICON_MAMMAL for digitigrade

### Damage Overlay

**Type:** "robotic"

- Shows robotic damage effects
- Special damage examine messages
- Uses nano-specific descriptions

---

## Configuration

### Roundstart Availability

**File:** `config/game_options.txt`

```
ROUNDSTART_RACES protean
```

Enable/disable by commenting/uncommenting this line.

---

## TGUI Files

None - uses standard MOD interface

---

## Core Proc Edits

### Modified Procs

**`/datum/outfit/proc/equip()`**

- **Addition:** Sends COMSIG_OUTFIT_EQUIP signal
- **Purpose:** Allows protean species to handle outfit equipment specially
- **Impact:** Minimal - only sends signal if species exists

**`/obj/item/bodypart`**

- **Addition:** `var/bodypart_species`
- **Purpose:** Tracks which species a bodypart belongs to
- **Impact:** Minimal - single var addition

---

## Modular Overwrites

### Files That Override Base Code

**`code/outfit_signal.dm`**

- Overrides: `/datum/outfit/equip()`
- Adds signal for protean outfit handling

---

## Credits

**Original Authors (Bubberstation):**

- Waterpig / @Majkl-j - Primary developer
- The Sharkenning / @StrangeWeirdKitten - Contributor

**Port to NovaSector:**

- Completed: October 14, 2025
- All systems adapted for NovaSector structure

---

## File Structure

```
modular_nova/modules/proteans/
├── code/
│   ├── _defines.dm              # All defines, constants, signals
│   ├── _helpers.dm              # isprotean() helper
│   ├── protean_species.dm       # Species datum, outfit handling
│   ├── protean_bodyparts.dm     # Custom bodypart system
│   ├── protean_verbs.dm         # Player abilities
│   ├── protean_status_effects.dm# Status effects
│   ├── protean_modsuit.dm       # Modsuit control, assimilation
│   ├── protean_modsuit_core.dm  # Power system
│   ├── protean_prefab.dm        # Empty bodies
│   ├── protean_servo_module.dm  # Buff module
│   ├── protean_cargo.dm         # Supply packs
│   ├── nanite_organ_element.dm  # Organ element
│   ├── outfit_signal.dm         # Outfit hook
│   ├── signal_defines.dm        # (placeholder)
│   └── organs/
│       ├── protean_brain.dm     # Core with revival
│       ├── protean_stomach.dm   # Metal storage
│       ├── protean_heart.dm     # Movement processor
│       ├── protean_eyes.dm      # Vision
│       ├── protean_ears.dm      # Hearing
│       ├── protean_tongue.dm    # Speech
│       └── protean_liver.dm     # Reagent processing
├── icons/
│   └── protean.dmi              # All sprites
├── readme.md                     # This file
├── INTEGRATION_NOTES.md         # Port notes
└── SETUP_COMPLETE.md            # Setup guide
```

---

## Constants Reference

| Constant                  | Value      | Description                    |
| ------------------------- | ---------- | ------------------------------ |
| PROTEAN_STOMACH_FULL      | 10         | Max metal storage (sheets)     |
| PROTEAN_STOMACH_FALTERING | 0.5        | Minimum for operation          |
| PROTEAN_METABOLISM_RATE   | 2000       | Base consumption rate          |
| PROTEAN_LIMB_TIME         | 30 SECONDS | Dismembered limb lifetime      |
| REGEN_TIME                | 30 SECONDS | Cooldown between healing ticks |

---

## Trait List

### Inherited Traits

- TRAIT_ADVANCEDTOOLUSER
- TRAIT_CAN_STRIP
- TRAIT_LITERATE
- TRAIT_MUTANT_COLORS
- TRAIT_NOBREATH
- TRAIT_ROCK_EATER
- TRAIT_STABLEHEART
- TRAIT_NOHUNGER
- TRAIT_LIMBATTACHMENT
- TRAIT_GENELESS
- TRAIT_NO_HUSK
- TRAIT_NO_DNA_SCRAMBLE
- TRAIT_SYNTHETIC
- TRAIT_TOXIMMUNE
- TRAIT_NEVER_WOUNDED
- TRAIT_VIRUSIMMUNE
- TRAIT_RADIMMUNE
- TRAIT_EASYDISMEMBER
- TRAIT_RDS_SUPPRESSED
- TRAIT_MADNESS_IMMUNE
- TRAIT_NODEATH

---

## Tips & Strategies

### For Protean Players

**Metal Management:**

- Keep 3+ sheets for safety buffer
- Carry extra metal in storage module
- Use low power when idling
- Don't waste metal on unnecessary heals

**Combat:**

- You're fragile - avoid direct combat
- Use modsuit modules for protection
- Retreat to suit when low health
- Let others wear you for buffs

**Support Role:**

- Excel as mobile support platform
- Let doctors/engineers wear you
- Provide buffs at critical moments
- Act as emergency backup for specialists

**Survival:**

- Always have backup refactory in cargo
- Don't go into dangerous areas alone
- Keep metal reserves accessible
- Coordinate with roboticist for organ supply

### For Medical Personnel

**Treating Proteans:**

- Cannot use normal medicine
- Can feed them metal for emergency heal
- Keep refactory organs in stock
- Learn the revival procedure

**Dead Protean Revival:**

1. Screwdriver suit open
2. Insert refactory
3. Wait 5 minutes
4. Done!

**Organ Surgery:**

- Only protean organs work
- Organic organs auto-reject
- Order from cargo as needed

### For Crew Members

**Wearing a Protean:**

- Can wear their modsuit like armor
- Protean must be inside (suit form)
- Receive powerful temporary buffs
- Servo abilities controlled by protean
- Can be locked onto you (ask nicely)

**Benefits:**

- Movement buff: Run very fast
- Medical buff: 2x surgery speed
- Engineering buff: Faster construction
- All with 60s cooldown

---

## Known Issues & Limitations

### Design Limitations

- Cannot use vent crawling (commented out)
- No support for soup pot mechanics (NovaSector doesn't have proc)
- Limited to specific organ types
- Cannot benefit from own servo modules

### Interaction Notes

- Protean suits show as critical on crew monitor when dead
- Cannot be cloned traditionally
- EMP causes drugginess despite being synthetic
- Memory reset is manual (pen use)

---

## API Reference

### Helper Procs

```dm
isprotean(A) // Returns TRUE if A is a protean
```

### Species Procs

```dm
/datum/species/protean/proc/equip_modsuit(mob/living/carbon/human/gainer)
// Equips the species modsuit on species gain

/datum/species/protean/proc/outfit_handling(datum/outfit/outfit, visuals_only)
// Handles outfit equipment for proteans

/datum/species/protean/proc/organ_reject(mob/living/source, obj/item/organ/inserted)
// Rejects non-compatible organs

/datum/species/protean/proc/reject_now(mob/living/source, obj/item/organ/organ)
// Physically removes rejected organ
```

### Brain Procs

```dm
/obj/item/organ/brain/protean/proc/handle_refactory(obj/item/organ)
// Checks refactory status, damages protean if missing

/obj/item/organ/brain/protean/proc/handle_orchestrator(obj/item/organ)
// Checks orchestrator status, applies slowdown if missing

/obj/item/organ/brain/protean/proc/go_into_suit(forced)
// Retreats protean into modsuit

/obj/item/organ/brain/protean/proc/leave_modsuit()
// Exits protean from modsuit

/obj/item/organ/brain/protean/proc/replace_limbs()
// Heals all organs and limbs using metal

/obj/item/organ/brain/protean/proc/revive()
// Revives dead protean

/obj/item/organ/brain/protean/proc/revive_timer()
// Starts 5 minute revival countdown
```

### Modsuit Procs

```dm
/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
// Forcibly drops the suit

/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock(forced)
// Locks/unlocks suit on wearer

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_theme(mob/user, plating)
// Copies appearance from MOD plating

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_modsuit(mob/user, modsuit, forced)
// Absorbs another modsuit

/obj/item/mod/control/pre_equipped/protean/proc/unassimilate_modsuit(mob/living/user, forced)
// Ejects absorbed modsuit

/obj/item/mod/control/pre_equipped/protean/proc/ooc_escape(mob/living/carbon/user)
// Handles OOC escape/safeword
```

---

## Debugging & Admin Tools

### Admin Commands

**Healing Dead Protean:**

```dm
// Give them a new refactory
var/mob/living/carbon/human/H = <target>
var/obj/item/organ/stomach/protean/S = new()
S.Insert(H, TRUE)
```

**Instant Revival:**

```dm
// Skip the 5 minute timer
var/obj/item/organ/brain/protean/B = H.get_organ_slot(ORGAN_SLOT_BRAIN)
B.revive()
```

**Add Metal:**

```dm
var/obj/item/organ/stomach/protean/S = H.get_organ_slot(ORGAN_SLOT_STOMACH)
S.metal = 10 // Fill to max
```

---

## Version History

**v1.0** - October 14, 2025

- Initial port from Bubberstation
- All core systems implemented
- Full compilation achieved
- Character creation enabled
- Spawn with full energy (10 metal sheets)
- Retract on HARD_CRIT

---

## Support & Troubleshooting

### Common Issues

**Q: Protean spawns with low/no energy**
A: Fixed - now spawns with full 10 sheets

**Q: Protean doesn't retract when critically hurt**
A: Check for HARD_CRIT state, should auto-retract

**Q: Cannot insert organs**
A: Only protean-specific organs work, order from cargo

**Q: Servo module doesn't work**
A: Must be worn by someone else, not the protean

**Q: Cannot remove suit**
A: Working as intended - use Ctrl+Shift+Click to empty storage

### Debug Checks

If something isn't working:

1. Check refactory exists: `get_organ_slot(ORGAN_SLOT_STOMACH)`
2. Check metal level: `stomach.metal`
3. Check dead state: `brain.dead`
4. Check suit reference: `species.species_modsuit`
5. Verify species type: `isprotean(mob)`

---

## See Also

- **INTEGRATION_NOTES.md** - Port details and testing checklist
- **SETUP_COMPLETE.md** - Setup completion status
- **Bubberstation Source** - Original implementation reference

---

_"Trillions of small machines swarm into a single crewmember."_
