# Doodlestein Planning & Beads Methodology
> Word-for-word prompts from @doodlestein's workflow

---

## PHASE 1: Plan Creation & Refinement

### 1A. Initial Plan from Existing Code (Claude Code)

Use when adding features to existing codebase:

```
Study all the relevant code from [REFERENCE_PROJECT] for implementing this feature, 
then explain how the corresponding feature in [TARGET_PROJECT] would have to differ. 
Create an initial cut at a plan.
```

### 1B. Expand Plan with Insights (Claude Code)

```
Check over the [REFERENCE] code again for more insights and understanding into 
how the feature was implemented and then use those insights to expand and 
improve the plan document in-place.
```

### 1C. GPT Pro Plan Review (Copy to GPT Pro Web)

**⚠️ MANUAL STEP: Copy plan to GPT 5.2 Pro with Extended Reasoning**

```
Carefully review this entire plan for me and come up with your best revisions 
in terms of better architecture, new features, changed features, etc. to make 
it better, more robust/reliable, more performant, more compelling/useful, etc. 
For each proposed change, give me your detailed analysis and rationale/justification 
for why it would make the project better along with the git-diff style change 
versus the original plan shown below:
```

### 1D. Integrate GPT Revisions (Claude Code)

```
OK, now integrate these revisions to the markdown plan in-place; use ultrathink 
and be meticulous. At the end, you can tell me which changes you wholeheartedly 
agree with, which you somewhat agree with, and which you disagree with:

```[Paste GPT output here]```
```

### 1E. Multi-Model Synthesis (GPT Pro Web)

**⚠️ MANUAL STEP: When you have plans from 3 different LLMs**

```
I asked 3 competing LLMs to do the exact same thing and they came up with 
pretty different plans which you can read below. I want you to REALLY carefully 
analyze their plans with an open mind and be intellectually honest about what 
they did that's better than your plan. Then I want you to come up with the best 
possible revisions to your plan (you should simply update your existing document 
for your original plan with the revisions) that artfully and skillfully blends 
the "best of all worlds" to create a true, ultimate, superior hybrid version 
of the plan that best achieves our stated goals and will work the best in 
real-world practice to solve the problems we are facing and our overarching 
goals while ensuring the extreme success of the enterprise as best as possible; 
you should provide me with a complete series of git-diff style changes to your 
original plan to turn it into the new, enhanced, much longer and detailed plan 
that integrates the best of all the plans with every good idea included (you 
don't need to mention which ideas came from which models in the final revised 
enhanced plan):
```

---

## PHASE 2: Plan → Beads Conversion

### 2A. Convert Plan to Beads (Claude Code)

```
OK so now read ALL of [PLAN_FILE.md]; please take ALL of that and elaborate 
on it and use it to create a comprehensive and granular set of beads for all 
this with tasks, subtasks, and dependency structure overlaid, with detailed 
comments so the whole thing is totally self-contained and self-documenting 
(including relevant background, reasoning/justification, considerations, etc.-- 
anything we'd want our "future self" to know about the goals and intentions 
and thought process and how it serves the over-arching goals of the project.). 
The beads should be so detailed that we never need to consult back to the 
original markdown plan document. Remember to ONLY use the `bd` tool to create 
and modify the beads and add the dependencies. Use ultrathink.
```

---

## PHASE 3: Bead Polish Loop ("Measure N Times")

### 3A. Iterative Bead Refinement (Run 6-9 times)

```
Reread AGENTS dot md so it's still fresh in your mind. Then read ALL of 
[PLAN_FILE.md]. Use ultrathink. Check over each bead super carefully-- are 
you sure it makes sense? Is it optimal? Could we change anything to make 
the system work better for users? If so, revise the beads. It's a lot easier 
and faster to operate in "plan space" before we start implementing these things!

DO NOT OVERSIMPLIFY THINGS! DO NOT LOSE ANY FEATURES OR FUNCTIONALITY! 

Also make sure that as part of the beads we include comprehensive unit tests 
and e2e test scripts with great, detailed logging so we can be sure that 
everything is working perfectly after implementation. It's critical that 
EVERYTHING from the markdown plan be embedded into the beads so that we never 
need to refer back to the markdown plan and we don't lose any important context 
or ideas or insights into the new features planned and why we are making them.
```

### 3B. Fresh Context Reset (New CC Session)

When improvements flatline, start a fresh session:

```
First read ALL of the AGENTS dot md file and README dot md file super carefully 
and understand ALL of both! Then use your code investigation agent mode to fully 
understand the code, and technical architecture and purpose of the project. 
Use ultrathink.
```

Then follow up with:

```
We recently transformed a markdown plan file into a bunch of new beads. I want 
you to very carefully review and analyze these using `bd` and `bv`.
```

...then run the 3A prompt again.

---

## Quick Reference: Prompt Selection

| Situation | Prompt | Tool |
|-----------|--------|------|
| Starting from existing code | 1A + 1B | Claude Code |
| Plan needs architecture review | 1C | GPT Pro (web) |
| Integrating GPT suggestions | 1D | Claude Code |
| Have 3 competing plans | 1E | GPT Pro (web) |
| Ready to create beads | 2A | Claude Code |
| Polish beads (repeat 6-9x) | 3A | Claude Code |
| Hit improvement plateau | 3B → 3A | New CC session |

---

## Model Recommendations

| Task | Best Model | Why |
|------|------------|-----|
| Plan creation | Claude Code (Opus) | Code access needed |
| Plan review | GPT 5.2 Pro Extended | Deep reasoning, no code needed |
| Plan integration | Claude Code (Opus) | Needs to write to files |
| Multi-model synthesis | GPT 5.2 Pro Extended | Final arbiter |
| Plan → Beads | Claude Code (Opus) | Needs bd/br tools |
| Bead polish | Claude Code (Opus) | Needs bd/br tools |
| Final polish | Codex (high reasoning) | Fresh perspective |

---

## Key Philosophy

> "Planning tokens are far fewer and cheaper than implementation tokens."

- Plans fit in context windows → models reason better
- Iteration in "plan space" is cheap vs. code changes
- Detailed plans enable agent swarms to implement "mechanically"
- Spend 85%+ of time on planning, not implementation
