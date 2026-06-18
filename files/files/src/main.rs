use iced::{Element, Subscription, Task, Theme, widget::text};

struct TheFiles {}

#[derive(Debug, Clone)]
enum Message {
    Change,
}

impl TheFiles {
    fn theme(&self) -> Theme {
        Theme::Dracula
    }

    fn subscription(&self) -> Subscription<Message> {
        Subscription::none()
    }

    fn update(&mut self, message: Message) -> Task<Message> {
        match message {
            _ => Task::none(),
        }
    }

    fn view(&self) -> Element<'_, Message> {
        text!("Hiya").into()
    }

    fn new() -> (Self, Task<Message>) {
        // let (boot, task) = TheFiles::new();
        let instance = TheFiles {};

        (instance, Task::none())
    }
}

fn main() -> iced::Result {
    iced::application("The Files", TheFiles::update, TheFiles::view)
        .theme(TheFiles::theme)
        .subscription(TheFiles::subscription)
        .run_with(TheFiles::new)
}
