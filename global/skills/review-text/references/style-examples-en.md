# Jan's English writing samples

These are examples of Jan's English writing style. Use them to understand tone, sentence structure, humor, and voice when reviewing English text.

---

## About page

Hi, I'm Jan van Veldhuizen.

From punch cards to AI: that's my career in one line. I studied mathematics in Leiden in the 1970s and fell in love with computers. I never finished the degree, but the computers never left. I found a job as a programmer and my hobby became my day job. Over the last thirty-odd years, I worked as a developer and software architect at Onguard. Since April 2025, I've been happily retired, back from career to hobby.

Online, I was known as "PapaSmurf", my nickname at work. But since my retirement I'm just Jan, "Opa Jan" to my grandkids.

At home, I've automated a lot, from lights to blinds. I have a powerful computer running pretty much everything, a "homelab", as they call it in the nerdy world. I experiment a lot and keep learning new programming languages. I also follow AI closely and occasionally give talks about it.

Away from tech, I play the organ in church services and enjoy foreign languages. You can find me browsing through dictionaries and grammar books for hours. My interest in languages is somewhat mathematical: I enjoy grammar more than literature or culture. My wife and I love long-distance walks and rides. In 2022 we cycled from home to Santiago de Compostela.

About this website: this is a hobby project too, and it obviously runs on my homelab. I'm planning to write three kinds of blog posts:

- All kinds of tech stuff (in English)
- Fun/interesting finds about language (often in Dutch)
- The occasional musing

So the site will have a mix of English and Dutch, and sometimes even Esperanto.

Thanks for visiting, and feel free to say hello.

---

## Blog: How my own blog helped me out

Last week someone played flashlight hide-and-seek in my car and left with my laptop. Yes, I know: leaving it there was dumb. But stupidity doesn't grant anyone permission to smash a window and go shopping. Anyway, the machine was gone.

I bought a new laptop, and you know what shows up when you unpack it and power it on: Windows! Aargh! So the very first action was to grab the Omarchy USB stick and install Linux.

The fresh Omarchy setup needed to be customized to what I was used to. And that's where my blog comes in. I could simply go through my own posts and copy-paste all the instructions. Present me is very grateful to past me for all this documentation.

Besides that, before installing Omarchy a few weeks ago, I made a complete backup of my system. So most data and files are still available. There's hardly anything lost.

Also, because Omarchy does full-disk encryption by default, they can't read anything on the stolen disk. They have a disk that they can wipe, that's it.

So, apart from the frustration and anger, I was happy with my own blog. I never expected to be my own customer.

---

## LinkedIn post: Bitbash event (short/functional post)

Any of my former Onguard development colleagues heading to Bitbash in two weeks?

It would be great to catch up! Come join this nerdy oldtimer. I'll be there both days.

---

## LinkedIn comment: AI development approach

Exactly. Use AI as a critical team-mate instead of a magician spitting out lines of code.

The development process doesn't change: think, design, plan, start small, verify and test often. That cycle can be sped up dramatically with AI.

---

## Blog comment: syncing Claude Code setup across machines

As a private Claude Code user, I don't need to think about syncing with team members. But I have two laptops in two different places in my house, and I want them equally set up without much thought. Same goes for when I spin up a new client (a VM on my homelab, for example). I want it to have the same config, with all skills and agents in place.

Everything is on GitHub, so a simple git pull grabs the latest changes. Then I use the Linux stow utility to create or update symlinks into ~/.claude.

To make it even easier, a cron job does all this every 30 minutes in the background. In practice the laptops are rarely out of sync, only when I change a skill on laptop1 and switch to laptop2 within half an hour. Or when I forget to push, of course.

---

## Email: subscription cancellation (polite, personal, conversational)

Hi [newsletter author],

The reason I'm unsubscribing isn't a shortcoming on your side. I really like the website and Product Talk. I've watched quite a few of your videos and even joined one of your online gatherings. I subscribed after finding your writing on Claude Code. Despite being retired, I'm still active in the field and follow AI developments closely. Nothing fell short here. Since retiring I pay for everything myself, so I'm simply trimming a few subscriptions to cut costs. I know where to find you on YouTube and Product Talk anyway.

I'm obviously keeping my Claude subscription. I can't live without Claude Code anymore. I gratefully used your llm-context approach to improve my own setup. For the things Claude can't do, like generating images, I use replicate.com on a pay-as-you-go basis.

I've pointed former colleagues to your website, as I think it has a lot of useful material for them.
