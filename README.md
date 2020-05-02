# SchedJulia

SchedJulia is an appointment scheduling script written in Julia.

## Overview

SchedJulia uses the concept of appointments with required duration and attendees, crossed with the attendees' availabilities to produce a satisfying schedule.

### Prerequisites

- [Julia](https://julialang.org/)
- An automated conversion system between your calendar/spreadsheet and the `.txt` files here is recommended.
  - This way, the integer units representing time and be converted to real time expressions.

### Files

- SchedJulia uses integer units to represent time. Of course, these units can be scaled to represent different timeslots of the time period.
  - For example, the range `[0-23]` can be used to represent the 24 hours in one day.
- Appointments to be scheduled include their unit duration and attendees, stored in `appointments.txt`.

  ```txt
  <duration>|<attendee>,<attendee>,...
  ...
  ```

- Availabilities of individual attendees are stored in `availability.txt`.

  ```txt
  <attendee>|<timeslot>,<timeslot>,...
  ...
  ```

- Follow the format of the above templates or example files closely, and do not include newlines at the end of the files.

## Usage

After loading `appointments.txt` and `availability.txt`, run the script.

```sh
julia schedjulia.jl
```

### Output

If a successful schedule arrangement is found, the output will be in `schedule.txt`, in the following format.

```txt
<start_time>:<end_time>|<attendee>,<attendee>,...
...
```

If no successful arrangement can be found, SchedJulia will output "`NO SCHEDULE POSSIBLE`".

## Development/Pages

- [**Homepage**](https://leglesslamb.gitlab.io/post/schedjulia)
- [**GitLab**](https://gitlab.com/leglesslamb/schedjulia)
  - Working issues and Merge Requests (MRs) are reviewed.
  - Bug reports and feature requests are preferred.
- [**GitHub (Mirror)**](https://github.com/leglesslamb/schedjulia)
  - Bug reports and feature requests are accepted.
