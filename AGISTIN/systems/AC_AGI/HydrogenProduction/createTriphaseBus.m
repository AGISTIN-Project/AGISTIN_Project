clear FeedbackDCBus
FeedbackDCBus = Simulink.Bus;
FeedbackDCBus.Elements(1) = Simulink.BusElement;
FeedbackDCBus.Elements(1).Name = 'connected';
FeedbackDCBus.Elements(1).DataType = 'double';
FeedbackDCBus.Elements(2) = Simulink.BusElement;
FeedbackDCBus.Elements(2).Name = 'enabled';
FeedbackDCBus.Elements(2).DataType = 'double';
FeedbackDCBus.Elements(3) = Simulink.BusElement;
FeedbackDCBus.Elements(3).Name = 'DCBus_isset';
FeedbackDCBus.Elements(3).DataType = 'double';

clear FeedbackACBus
FeedbackACBus = Simulink.Bus;
FeedbackACBus.Elements(1) = Simulink.BusElement;
FeedbackACBus.Elements(1).Name = 'connected';
FeedbackACBus.Elements(1).DataType = 'double';
FeedbackACBus.Elements(2) = Simulink.BusElement;
FeedbackACBus.Elements(2).Name = 'enabled';
FeedbackACBus.Elements(2).DataType = 'double';

clear CommandDCBus
CommandDCBus = Simulink.Bus;
CommandDCBus.Elements(1) = Simulink.BusElement;
CommandDCBus.Elements(1).Name = 'connect';
CommandDCBus.Elements(1).DataType = 'double';
CommandDCBus.Elements(2) = Simulink.BusElement;
CommandDCBus.Elements(2).Name = 'enable';
CommandDCBus.Elements(2).DataType = 'double';

clear CommandACBus
CommandACBus = Simulink.Bus;
CommandACBus.Elements(1) = Simulink.BusElement;
CommandACBus.Elements(1).Name = 'connect';
CommandACBus.Elements(1).DataType = 'double';
CommandACBus.Elements(2) = Simulink.BusElement;
CommandACBus.Elements(2).Name = 'enable';
CommandACBus.Elements(2).DataType = 'double';
